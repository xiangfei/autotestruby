class ProxiesController < ApplicationController
  before_action :set_proxy, only: [:show, :edit, :update, :destroy]

  # GET /proxies
  # GET /proxies.json
  def index
    @q = Proxy.ransack(params[:q])

    @proxies = @q.result.page(params[:page])
  end

  # GET /proxies/1
  # GET /proxies/1.json
  def show
  end

  # GET /proxies/new
  def new
    @proxy = Proxy.new
  end

  # GET /proxies/1/edit
  def edit
  end

  # POST /proxies
  # POST /proxies.json
  def create
    @proxy = Proxy.new(proxy_params)

    respond_to do |format|
      if @proxy.save
        format.html { redirect_to @proxy, notice: "Proxy was successfully created." }
        format.json { render :show, status: :created, location: @proxy }
      else
        format.html { render :new }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proxies/1
  # PATCH/PUT /proxies/1.json
  def update
    respond_to do |format|
      if @proxy.update(proxy_params)
        format.html { redirect_to @proxy, notice: "Proxy was successfully updated." }
        format.json { render :show, status: :ok, location: @proxy }
      else
        format.html { render :edit }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proxies/1
  # DELETE /proxies/1.json
  def destroy
    @proxy.destroy
    respond_to do |format|
      format.html { redirect_to proxies_url, notice: "Proxy was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proxy
    @proxy = Proxy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def proxy_params
    params.require(:proxy).permit(:name, :url, :proxytype)
  end
end
