class ApplicationController < ActionController::Base
  include MessageHelper
  before_action :authenticate_user!, :except =>[:gettestcasebycaseid]
  after_action :record_log

  def record_log
    if @recordlog
      @log = Log.new
      @log.controller = request.params[:controller]
      @log.action = request.params[:action]
      @log.params = JSON.dump(request.params)
      @log.user = current_user.email
      @log.method = request.request_method
      @log.objid = @recordlog.id
      @log.objname = @recordlog.name
      @log.modelclass = @recordlog.class.name
      @log.save
    end
  end
end
