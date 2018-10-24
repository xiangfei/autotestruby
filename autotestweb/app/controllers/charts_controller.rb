class ChartsController < ApplicationController
  include ChartsHelper

  def app_testcase_stastics
    app = App.find(params[:id])
    @app_chart_status = app_testcase_chart_status app
    @user_list = []
    @success_list = []
    @failure_list = []
    @error_list = []
    analy = {}
    @app_chart_status.each do |key, value|
      app, status, user = key
      count = value
      if not analy[user]
        analy[user] = {"errorlist" => 0, "successlist" => 0, "failurelist" => 0}
      end
      if status == "脚本运行失败"
        analy[user]["errorlist"] = analy[user]["errorlist"] + count.to_i
      elsif status == "用例执行成功"
        analy[user]["successlist"] = analy[user]["successlist"] + count.to_i
      elsif status == "用例执行失败"
        analy[user]["failurelist"] = analy[user]["failurelist"] + count.to_i
      else
        logger.warn("unexcept skip calc")
      end
    end
    analy.each do |useremail, valuehash|
      @user_list << useremail.to_s
      @success_list << valuehash["successlist"]
      @failure_list << valuehash["failurelist"]
      @error_list << valuehash["errorlist"]
    end
    puts analy

    puts "xxxxxxx"
  end

  def project_testcase_stastics
    project = Project.find(params[:id])
    @project_chart_status = project_testcase_chart_status project
    @app_list = []
    @success_list = []
    @failure_list = []
    @error_list = []
    analy = {}
    @project_chart_status.each do |key, value|
      app, status  = key
      count = value
      if not analy[app]
        analy[app] = {"errorlist" => 0, "successlist" => 0, "failurelist" => 0}
      end
      if status == "脚本运行失败"
        analy[app]["errorlist"] = analy[app]["errorlist"] + count.to_i
      elsif status == "用例执行成功"
        analy[app]["successlist"] = analy[app]["successlist"] + count.to_i
      elsif status == "用例执行失败"
        analy[app]["failurelist"] = analy[app]["failurelist"] + count.to_i
      else
        logger.warn("unexcept skip calc")
      end
    end
    analy.each do |app, valuehash|
      @app_list << app.to_s
      @success_list << valuehash["successlist"]
      @failure_list << valuehash["failurelist"]
      @error_list << valuehash["errorlist"]
    end
  end

  def all_testcase_stastics
  end
end
