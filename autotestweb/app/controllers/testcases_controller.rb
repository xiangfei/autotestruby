class TestcasesController < ApplicationController
  include TestcasesHelper
  include RuntestcaseHelper
  before_action :set_testcase, only: [:show, :edit, :update, :destroy]

  # GET /testcases
  # GET /testcases.json
  def index
    logger.debug(params)
    @case_type = params[:case_type]
    if @case_type
      @q = Testcase.where(:case_type => @case_type).ransack(params[:q])
    else
      @q = Testcase.ransack(params[:q])
    end
    @testcases = @q.result.page(params[:page])
    if params[:format] == "xlsx"
      @testcases = Testcase.where(:case_type => @case_type)
    end
    #redirect_to :action=>"index" , :case_type=> params[:case_type]

  end

  def template
  end

  def get_testcases_by_app_id
    app_id = params[:app_id]
    @testcases = Testcase.where(:app_id => app_id)
    render json: @testcases.to_json
  end

  # get run api form
  def getruntestcase
    @runtestcase = Runtestcase.new
    @servers = Server.all
    @case_type = params[:case_type]
    @runtestcase.casetype = @case_type
    @proxies = Proxy.where(:proxytype => @case_type)
    render "runtestcase.html.erb"
  end

  # post form
  def postruntestcase
    logger.debug(params)
    puts params
    logtext = ""
    @testcasetype = params[:runtestcase][:testcasetype]
    @app_id = params[:runtestcase][:app_id]
    @mail_to = params[:runtestcase][:mail_to]
    @app = App.find(@app_id)
    if params[:runtestcase][:proxy]
      @proxy = params[:runtestcase][:proxy]
    else
      @proxy = ""
    end
    @env = params[:runtestcase][:env]
    @type = params[:runtestcase][:casetype]
    datetime = Time.now.strftime("%Y%m%d%H%M%S")
    outputfile = "#{datetime}.html"
    server = Server.find_by_ip(params[:runtestcase][:server])
    alltestcaselist = Testcase.where(:app_id => @app_id)
    params[:excludecase_list] = [] unless params[:excludecase_list]
    broadcastmessage("#{current_user.email} 在执行项目测试用例 #{@app.name} ", ispublic = true, notify = true)
    #需要执行的testcase
    if @testcasetype == "include"
      testcaselist = []
      if params[:case_list]
        params[:case_list].each do |includecaseid|
          tk = Testcase.find(includecaseid.to_i)
          testcaselist << tk.case_id
        end
      else
        alltestcaselist.each do |testcase|
          testcaselist << testcase.case_id
        end
      end
    else
      testcaselist = []
      alltestcaselist.each do |testcase|
        execute = true
        if params[:case_list]
          params[:case_list].each do |excludecaseid|
            if testcase.id == excludecaseid.to_i
              execute = false
              break
            end
          end
        end
        if execute
          testcaselist << testcase.case_id
        end
      end
    end
    status = remote_run_api_testcase(server, @app, testcaselist, outputfile, @env, @type, current_user.email, @mail_to, @proxy) do |message|
      runtestcaselogmessage(message, @app.id.to_s, @app.name)
      #broadcastmessage(message, ispublic = false, notify = false)
      logtext.concat message
    end
    #sleep 20
    #runtestcaselogmessage ("broadcastfinish"  @app.id.to_s)
    #broadcastmessage("broadcastfinish", ispublic = false, notify = false)
    @runtestcase = Runtestcase.new
    @runtestcase.server = params[:runtestcase][:server]
    @runtestcase.app = @app.name
    @runtestcase.env = @env
    @runtestcase.casetype = @type
    @runtestcase.logtext = logtext
    @runtestcase.user = current_user.email
    @runtestcase.runtype = @testcasetype
    @runtestcase.reportname = outputfile
    @runtestcase.mailto = @mail_to
    if reportexist? @runtestcase
      @runtestcase.status = true
    else
      @runtestcase.status = false
    end
    @runtestcase.reportstatus = reportstatus @runtestcase
    respond_to do |format|
      Runtestcase.transaction do
        if @runtestcase.save
          @recordlog = @runtestcase
          if params[:case_list]
            params[:case_list].each do |excludecaseid|
              releation = TestcaseRuncaseRelation.new
              releation.testcase_id = excludecaseid
              releation.runtestcase_id = @runtestcase.id
              releation.save
            end
          end
          #sleep 10
          #runtestcaselogmessage("broadcastfinish" ,  @app.id.to_s , @app.name)
          broadcastmessage("测试用例 #{@app.name} 执行完成", ispublic = false, notify = true)
          #broadcastmessage("broadcastfinish", ispublic = false, notify = true)
          TestreportMailer.send_runtestcasereport_mail(@runtestcase).deliver
          format.html { redirect_to :action => "index", notice: "Testcase run successfully." }
          format.json { render :show, status: :created, location: @runtestcase }
        else
          runtestcaselogmessage(@runtestcase.errors.to_s, @app.id.to_s, @app.name)
          #runtestcaselogmessage("broadcastfinish" ,  @app.id.to_s , @app.name)
          broadcastmessage("测试用例 #{@app.name} 执行完成", ispublic = false, notify = true)
          #broadcastmessage(@runtestcase.errors.to_s, ispublic = false, notify = false)
          #broadcastmessage("broadcastfinish", ispublic = false, notify = false)
          format.html { render :action => "index", notice: "testcase run failed" }
          format.json { render json: @runtestcase.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def testcaseerrlog
    @runtestcase = Runtestcase.find(params[:id])
  end

  def downloadreport
    logger.debug(params)
    runtestcase = Runtestcase.find(params[:id])
    download_send_htmlreport runtestcase
  end

  def excelupload
    logger.debug(params)
    @testcase = Testcase.new
  end

  def exceluploadpost
    logger.debug(params)
    overwrite = params[:testcase][:overwrite]
    excelfile = params[:testcase][:excelfile]
    if "true" == overwrite
      ov = true
    else
      ov = false
    end

    @filename = excelfile.original_filename
    FileUtils.mkdir("#{Rails.root}/public/upload") unless File.exist?("#{Rails.root}/public/upload")
    File.open("#{Rails.root}/public/upload/#{@filename}", "wb") do |f|
      f.write(excelfile.read)
    end
    # Roo 没看见io读
    workbook = Roo::Spreadsheet.open "#{Rails.root}/public/upload/#{@filename}", extension: :xlsx
    worksheets = workbook.sheets
    worksheets.each do |worksheet|
      number = 0
      #puts worksheet.row(1)
      workbook.sheet(worksheet).each_row_streaming do |row|
        #workbook.sheet(worksheet).each_cons do |row|
        case_id = row[0].cell_value.pure_html
        case_type = row[1].cell_value.pure_html
        case_name = row[2].cell_value.pure_html
        appname = row[3].cell_value.pure_html
        app = App.find_by_name(appname)
        if not app
          logger.warn("not found app , skip ")
        end
        if number == 0
          puts "skip  import title"
          number = number + 1
          next
        end
        testcase = Testcase.find_by_case_id(case_id)
        if testcase
          if ov
            testcase.case_type = case_type
            testcase.case_name = case_name
            testcase.app_id = app.id
            testcase.is_done = true
            testcase.save
            broadcastmessage("find #{testcase.case_id}, force update it successfully", ispublic = false, notify = false)
          else
            broadcastmessage("find #{testcase.case_id}, skip update it", ispublic = false, notify = false)

            next
          end
        else
          #create new one
          test = Testcase.new
          test.case_id = case_id
          test.case_type = case_type
          test.case_name = case_name
          test.app_id = app.id
          test.is_done = true
          test.save!
          broadcastmessage("not find #{test.case_id}, create new one", ispublic = false, notify = false)
        end
      end
    end
    broadcastmessage("broadcastfinish", ispublic = false, notify = false)

    File.delete("#{Rails.root}/public/upload/#{@filename}") if File.exist?("#{Rails.root}/public/upload/#{@filename}")
    redirect_to :action => :index
  end

  def runtestcaselogs
    @q = Runtestcase.order("id desc").ransack(params[:q])
    @runtestcases = @q.result.page(params[:page])
  end

  def testcasesvncontent
    @testcase = Testcase.find(params[:id])
    content = get_testcase_content_in_svn @testcase
    @svncontent = content
  end

  def updatetestcasesvncontent
    testcase = Testcase.find(params[:id])
    content = params[:testcase][:svncontent]
    update_testcase_content_in_svn(testcase, content)
    redirect_to :action => :testcasesvncontent, notice: "修改svn content success"
  end

  # GET /testcases/1
  # GET /testcases/1.json
  def show
    content = get_testcase_content_in_svn @testcase
    @svncontent = content
  end

  def gettestcasebycaseid
    caseid = params[:caseid]
    testcase = Testcase.find_by_case_id(caseid)
    if testcase
      render json: testcase
    else
      render json: []
    end
  end

  # GET /testcases/new
  def new
    @testcase = Testcase.new
  end

  # GET /testcases/1/edit
  def edit
    content = get_testcase_content_in_svn @testcase
    @svncontent = content
  end

  # POST /testcases
  # POST /testcases.json
  def create
    @testcase = Testcase.new(testcase_params)

    respond_to do |format|
      if @testcase.save
        @recordlog = @testcase
        content = params[:testcase][:svncontent]
        if content
          update_testcase_content_in_svn(@testcase, content)
        end

        broadcastmessage("#{current_user.email} add testcase #{@testcase.case_id}", ispublic = true, notify = true)
        format.html { redirect_to @testcase, notice: "Testcase was successfully created." }
        format.json { render :show, status: :created, location: @testcase }
      else
        format.html { render :new }
        format.json { render json: @testcase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testcases/1
  # PATCH/PUT /testcases/1.json
  def update
    respond_to do |format|
      if @testcase.update(testcase_params)
        @recordlog = @testcase
        content = params[:testcase][:svncontent]
        if content
          update_testcase_content_in_svn(@testcase, content)
        end
        format.html { redirect_to @testcase, notice: "Testcase was successfully updated." }
        format.json { render :show, status: :ok, location: @testcase }
      else
        format.html { render :edit }
        format.json { render json: @testcase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testcases/1
  # DELETE /testcases/1.json
  def destroy
    delete_testcase_svn_file(@testcase)
    @testcase.destroy
    respond_to do |format|
      @recordlog = @testcase
      format.html { redirect_to testcases_url, notice: "Testcase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_testcase
    @testcase = Testcase.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def testcase_params
    params.require(:testcase).permit(:case_id, :case_name, :is_done, :app_id, :case_type)
  end
end
