class ConfigsController < ApplicationController
  include ConfigsHelper
  before_action :set_config, only: [:show, :edit, :update, :destroy]

  # GET /configs
  # GET /configs.json
  def index
    @env = params[:env]

    if @case_type
      @q = Config.where(:env => @env).ransack(params[:q])
    else
      @q = Config.ransack(params[:q])
    end
    @configs = @q.result.page(params[:page])
  end

  # GET /configs/1
  # GET /configs/1.json
  def show
    @svncontent = get_config_content_in_svn @config
  end

  # GET /configs/new
  def new
    @config = Config.new
  end

  # GET /configs/1/edit
  def edit
    @svncontent = get_config_content_in_svn @config
  end

  # POST /configs
  # POST /configs.json
  def create
    @config = Config.new(config_params)
    content = params[:config][:svncontent]
    if content
      update_config_content_in_svn(@config, content)
    end
    respond_to do |format|
      if @config.save
        @recordlog = @config
        format.html { redirect_to @config, notice: "Config was successfully created." }
        format.json { render :show, status: :created, location: @config }
      else
        format.html { render :new }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  def svncontent
    @config = Config.find(params[:id])
    puts @config
    content = get_config_content_in_svn @config
    puts content
    @svncontent = content
  end

  def updatesvncontent
    config = Config.find(params[:id])
    content = params[:config][:svncontent]
    update_config_content_in_svn(config, content)

    redirect_to :action => :svncontent, notice: "修改svn content success"
  end

  # PATCH/PUT /configs/1
  # PATCH/PUT /configs/1.json
  def update
    respond_to do |format|
      if @config.update(config_params)
        content = params[:config][:svncontent]
        if content
          update_config_content_in_svn(@config, content)
        end
        @recordlog = @config
        format.html { redirect_to @config, notice: "Config was successfully updated." }
        format.json { render :show, status: :ok, location: @config }
      else
        format.html { render :edit }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /configs/1
  # DELETE /configs/1.json
  def destroy
    @config.destroy
    delete_svn_config_file @config
    @recordlog = @config
    respond_to do |format|
      format.html { redirect_to configs_url, notice: "Config was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_config
    @config = Config.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def config_params
    params.require(:config).permit(:app_id, :name, :description, :env, :content, :casetype)
  end
end
