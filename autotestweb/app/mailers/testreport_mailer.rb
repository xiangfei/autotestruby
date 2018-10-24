
class TestreportMailer < ApplicationMailer
  include RuntestcaseHelper

  def send_runtestcasereport_mail(runtestcase)
    @runtestcase = runtestcase
    if runtestcase.status == "1"
      attachments[runtestcase.reportname] = readtext(runtestcase)
      doc = Nokogiri::HTML readtext(runtestcase)
      @successratio, @success = doc.css("div.progress-bar-info").text.strip.split
      @errorratio, @error = doc.css("div.progress-bar-danger").text.strip.split
      @skipratio, @skip = doc.css("div.progress-bar-warning").text.strip.split
    end
    emailgroup = Emailgroup.find_by_name(runtestcase.mailto)
    if emailgroup
      mail_list = emailgroup.emails.collect { |email| email.name }
    else
      mail_list = []
    end
    mail(:subject => "#{runtestcase.app} 测试报告", :to => mail_list)
  end

  def send_mail(params = {})
    @url = "http://example.com/login"
    attachments["testssh.rb"] = File.read("/root/testssh.rb")
    mail(:subject => "abcAAAAAAAASDFADSFADSFADSFDASFASDF",
         :to => "xiangfei_2011@163.com").deliver
  end
end
