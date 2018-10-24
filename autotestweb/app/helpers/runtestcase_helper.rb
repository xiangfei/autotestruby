module RuntestcaseHelper
  include SshHelper

  def reportexist?(runtestcase)
    server = Server.find_by_ip(runtestcase.server)
    app = App.find_by_name(runtestcase.app)
    sourcefile = "#{app.project.folderpath}/#{app.project.name}/#{app.name}/#{runtestcase.casetype}/output/#{runtestcase.reportname}"
    begin
      copyfile(server.ip, server.username, server.password, server.port, sourcefile, runtestcase.reportname)
      File.delete(runtestcase.reportname) if File.exist?(runtestcase.reportname)
      true
    rescue
      false
    end
  end

  def readtext(runtestcase)
    server = Server.find_by_ip(runtestcase.server)
    app = App.find_by_name(runtestcase.app)
    sourcefile = "#{app.project.folderpath}/#{app.project.name}/#{app.name}/#{runtestcase.casetype}/output/#{runtestcase.reportname}"
    text = ""
    run(server.ip, server.username, server.password, server.port, "cat #{sourcefile}") do |data|
      text = text + data
    end
    text
  end

  def reportstatus(runtestcase)
    if reportexist?(runtestcase)
      doc = Nokogiri::HTML readtext(runtestcase)
      @errorratio, @error = doc.css("div.progress-bar-danger").text.strip.split
      if @errorratio =="0%"
        "用例执行成功"
      else
        "用例执行失败"
      end
    else
      "脚本运行失败"
    end
  end
end
