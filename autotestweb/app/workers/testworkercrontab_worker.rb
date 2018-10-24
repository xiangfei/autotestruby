require "sidekiq-scheduler"

class TestworkercrontabWorker
  include Sidekiq::Worker
  include RuntestcaseHelper
  include TestcasesHelper
  # args 直接传人delaytask id
  def perform(*args)
    # Do something
    puts args
    delaytask = Delaytask.find_by_id(args[0])
    if delaytask
      puts "run in backend"
      runtestcase delaytask
      puts "run delaytask success"
    else
      puts "not find delaytask"
    end
  end

  def runtestcase(delaytask)
    @mail_to = delaytask.mailto
    @app = App.find_by_name(delaytask.app)
    datetime = Time.now.strftime("%Y%m%d%H%M%S")
    outputfile = "#{datetime}.html"
    server = Server.find_by_ip(delaytask.server)
    alltestcaselist = Testcase.where(:app_id => @app.id)
    #需要执行的testcase
    logtext = String.new
    testcaselist = alltestcaselist.collect { |testcase| testcase.case_id }
    status = remote_run_api_testcase(server, @app, testcaselist, outputfile, delaytask.env, delaytask.apptype) do |message|
      logtext.concat message
    end
    @runtestcase = Runtestcase.new
    @runtestcase.server = delaytask.server
    @runtestcase.app = @app.name
    @runtestcase.env = delaytask.env
    @runtestcase.casetype = delaytask.apptype
    @runtestcase.logtext = logtext
    @runtestcase.user = "system"
    @runtestcase.reportname = outputfile
    @runtestcase.mailto = @mail_to
    if reportexist? @runtestcase
      @runtestcase.status = true
    else
      @runtestcase.status = false
    end
    @runtestcase.reportstatus = reportstatus @runtestcase
    Runtestcase.transaction do
      if @runtestcase.save
        @recordlog = @runtestcase
        TestreportMailer.send_runtestcasereport_mail(@runtestcase).deliver
      end
    end
  end
end
