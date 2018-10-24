module ConfigsHelper
  include SvnHelper

  def get_config_content_in_svn(config)
    auto_test_url = Rails.application.config.svn_autotest_url
    filename = config.name
    svn_url_base = "#{auto_test_url}/autotestscript"
    path = "#{config.app.project.name}/#{config.app.name}/#{config.casetype}/Config/environments"
    username = Rails.application.config.svn_username
    password = Rails.application.config.svn_password
    get_svn_file_content(path, filename, username, password, svn_url_base)
  end

  def sync_configfile_in_svn
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
          apiappfolder = "#{projectname}/#{appname}/api/Config/environments"
          list_svn_dir(apiappfolder, username, password, svn_url_base).split().each do |configfile|
            configenv = configfile.split(".rb")[-1]
            config = Config.where(:app_id => app.id, :env => configenv)
            if config.empty?
              puts "not find needs add"
              config = Config.new
              config.app_id = app.id
              config.name = configfile
              config.env = configenv
              config.casetype = "api"
              config.description = "add by scripts "
              config.save!
            else
              puts "find it skip "
            end

            webappfolder = "#{projectname}/#{appname}/web/Config/environments"
            list_svn_dir(webappfolder, username, password, svn_url_base).split().each do |configfile|
              configenv = configfile.split(".rb")[-1]
              config = Config.where(:app_id => app.id, :env => configenv)
              if config.empty?
                puts "not find needs add"
                config = Config.new
                config.app_id = app.id
                config.name = configfile
                config.env = configenv
                config.casetype = "web"
                config.description = "add by scripts "
                config.save!
              else
                puts "find it skip "
              end
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

  def delete_svn_config_file(config)
    auto_test_url = Rails.application.config.svn_autotest_url
    filename = config.name
    svn_url_base = "#{auto_test_url}/autotestscript"
    path = "#{config.app.project.name}/#{config.app.name}/#{config.casetype}/Config/environments"
    username = Rails.application.config.svn_username
    password = Rails.application.config.svn_password
    delete_svn_file(path, filename, username, password, svn_url_base)
  end

  def update_config_content_in_svn(config, content)
    auto_test_url = Rails.application.config.svn_autotest_url
    filename = config.name
    localfilename = Time.now.strftime("%Y%m%d%H%M%S") + filename
    svn_url_base = "#{auto_test_url}/autotestscript"
    #path = "#{testcase.app.project.name}/#{testcase.app.name}/#{testcase.case_type}/TestCase"
    path = "#{config.app.project.name}/#{config.app.name}/#{config.casetype}/Config/environments"
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
