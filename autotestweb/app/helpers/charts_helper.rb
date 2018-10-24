module ChartsHelper
  def app_testcase_chart_status(app)
    Runtestcase.where(:app => app.name).group(:app, :reportstatus, :user).order("count_id desc").count("id")
  end

  def project_testcase_chart_status(project)
    appnames = project.apps.collect &:name
    Runtestcase.where(:app => appnames).group(:app, :reportstatus ).order("count_id desc").count("id")
  end

  def all_testcase_chart_status 

    Runtestcase.group(:app, :reportstatus, :user).order("count_id desc").count("id")
  end

end
