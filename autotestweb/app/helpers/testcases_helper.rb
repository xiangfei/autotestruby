module TestcasesHelper
  include SshHelper
  include SvnHelper

  def remote_run_api_testcase(server, app, testcaselist, outputfile, env, type, testuser, mailto , proxy_server, &block)
    testcase = testcaselist.join(",")
    cmdstr = "source /etc/profile;cd #{app.project.folderpath};svn update; bundle exec ruby #{app.project.folderpath}/Main.rb  --includelist #{testcase} --outputfile   #{outputfile}  --env #{env} --project #{app.project.name} --service #{app.name} --type #{type}  --runserver #{server.ip}  --testuser #{testuser}   --mailto  #{mailto} "

    if proxy_server
      if not proxy_server.empty?
        cmdstr = cmdstr + "--proxy #{proxy_server}"
      end
    end
    puts cmdstr
    run(server.ip, server.username, server.password, server.port, cmdstr, &block)
  end

  def download_send_htmlreport(runtestcase)
    server = Server.find_by_ip(runtestcase.server)
    app = App.find_by_name(runtestcase.app)
    sourcefile = "#{app.project.folderpath}/#{app.project.name}/#{app.name}/#{runtestcase.casetype}/output/#{runtestcase.reportname}"
    puts sourcefile
    copyfile(server.ip, server.username, server.password, server.port, sourcefile, runtestcase.reportname)
    #send_file(runtestcase.reportname, :filename => runtestcase.reportname)
    File.open(runtestcase.reportname, "r") do |f|
      send_data f.read, :filename => runtestcase.reportname
    end
    File.delete(runtestcase.reportname) if File.exist?(runtestcase.reportname)
    #send_data(contents, :filename => filename)
  end

  def get_testcase_content_in_svn(testcase)
    auto_test_url = Rails.application.config.svn_autotest_url
    filename = "#{testcase.case_id.pure_html}.rb"
    svn_url_base = "#{auto_test_url}/autotestscript"
    path = "#{testcase.app.project.name}/#{testcase.app.name}/#{testcase.case_type}/TestCase"
    username = Rails.application.config.svn_username
    password = Rails.application.config.svn_password
    get_svn_file_content(path, filename, username, password, svn_url_base)
  end

  def sync_testcase_in_svn
    auto_test_url = Rails.application.config.svn_autotest_url
    svn_url_base = "#{auto_test_url}/autotestscript"
    username = Rails.application.config.svn_username
    password = Rails.application.config.svn_password

    list_svn_dir("", username, password, svn_url_base).split().each do |projectname|
      projectname = projectname.split("/")[-1]
      project = Project.find_by_name(projectname)
      if project
        puts "find projects sync apps"
        list_svn_dir(project.name, username, password, svn_url_base).split().each do |appname|
          appname = appname.split("/")[-1]
          app = App.find_by_name(appname)
          if app
            puts "find app "
          else
            puts "not find it add it "
            app = App.new
            app.name = appname
            app.description = "auto add by script"
            app.project_id = project.id
            app.save!
          end
          apiappfolder = "#{projectname}/#{appname}/api/TestCase"
          list_svn_dir(apiappfolder, username, password, svn_url_base).split().each do |apitestcaseid|
            apitestcaseid = apitestcaseid.split(".rb")[-1]
            puts apitestcaseid
            apitestcaseindb = Testcase.find_by_case_id(apitestcaseid)
            if apitestcaseindb
              puts "find #{apitestcaseindb}"
            else
              testcase = Testcase.new
              testcase.case_id = apitestcaseid
              testcase.case_type = "api"
              testcase.app_id = app.id
              testcase.is_done = true
              case_name = ""
              content = get_testcase_content_in_svn(testcase)
              content.split.each do |line|
                if line =~ /#用例名称:/
                  case_name = line.split(/#用例名称:/)[-1]
                  break
                elsif line =~ /#用例名称：/
                  case_name = line.split(/#用例名称：/)[-1]
                  break
                end
              end
              testcase.case_name = case_name
              testcase.save!
            end
          end
          webappfolder = "#{projectname}/#{appname}/web/TestCase"
          list_svn_dir(webappfolder, username, password, svn_url_base).split().each do |webtestcaseid|
            webtestcaseid = webtestcaseid.split(".rb")[-1]
            puts webtestcaseid
            webtestcaseidindb = Testcase.find_by_case_id(webtestcaseid)
            if webtestcaseidindb
              puts "find webtestcase api"
            else
              testcase = Testcase.new
              testcase.case_id = webtestcaseid
              testcase.case_type = "web"
              testcase.app_id = app.id
              testcase.is_done = true
              case_name = ""
              content = get_testcase_content_in_svn(testcase)
              content.split.each do |line|
                if line =~ /#用例名称:/
                  case_name = line.split(/#用例名称:/)[-1]
                  break
                elsif line =~ /#用例名称：/
                  case_name = line.split(/#用例名称：/)[-1]
                  break
                end
              end
              testcase.case_name = case_name
              testcase.save!
            end
          end
        end
      else
        puts "not find project"
        excludelist = Rails.application.config.autotest_project_exclude
        if excludelist.include? projectname
          puts "find igore projectname"
        else
          project = Project.new
          project.name = projectname
          project.description = "auto add by scripts needs to change manually"
          project.save
        end
      end
    end
  end

  def delete_testcase_svn_file(testcase)
    auto_test_url = Rails.application.config.svn_autotest_url
    filename = "#{testcase.case_id.pure_html}.rb"
    svn_url_base = "#{auto_test_url}/autotestscript"
    path = "#{testcase.app.project.name}/#{testcase.app.name}/#{testcase.case_type}/TestCase"
    username = Rails.application.config.svn_username
    password = Rails.application.config.svn_password
    delete_svn_file(path, filename, username, password, svn_url_base)
  end

  def update_testcase_content_in_svn(testcase, content)
    auto_test_url = Rails.application.config.svn_autotest_url
    filename = "#{testcase.case_id.pure_html}.rb"
    localfilename = Time.now.strftime("%Y%m%d%H%M%S") + filename

    svn_url_base = "#{auto_test_url}/autotestscript"
    path = "#{testcase.app.project.name}/#{testcase.app.name}/#{testcase.case_type}/TestCase"
    username = Rails.application.config.svn_username
    password = Rails.application.config.svn_password
    # write file to local
    File.open(localfilename, "wb") do |f|
      f.write(content)
    end
    # import to svn , needs to delete , before
    #删除远程文件
    delete_svn_file(path, filename, username, password, svn_url_base)
    #创建远程文件
    add_svn_file(path, filename, localfilename, username, password, svn_url_base)
    #删除本地文件
    File.delete(localfilename) if File.exist?(localfilename)
  end
end
