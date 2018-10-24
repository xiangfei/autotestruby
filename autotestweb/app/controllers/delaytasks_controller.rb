class DelaytasksController < ApplicationController
  before_action :set_delaytask, only: [:show, :edit, :update, :destroy]

  # GET /delaytasks
  # GET /delaytasks.json
  def index
    @q = Delaytask.ransack(params[:q])
    @delaytasks = @q.result.page(params[:page])
  end

  # GET /delaytasks/1
  # GET /delaytasks/1.json
  def show
  end

  # GET /delaytasks/new
  def new
    @delaytask = Delaytask.new
  end

  # GET /delaytasks/1/edit
  def edit
  end

  # POST /delaytasks
  # POST /delaytasks.json
  def create
    @delaytask = Delaytask.new(delaytask_params)

    respond_to do |format|
      if @delaytask.save
        format.html { redirect_to @delaytask, notice: 'Delaytask was successfully created.' }
        format.json { render :show, status: :created, location: @delaytask }
      else
        format.html { render :new }
        format.json { render json: @delaytask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delaytasks/1
  # PATCH/PUT /delaytasks/1.json
  def update
    respond_to do |format|
      if @delaytask.update(delaytask_params)
        format.html { redirect_to @delaytask, notice: 'Delaytask was successfully updated.' }
        format.json { render :show, status: :ok, location: @delaytask }
      else
        format.html { render :edit }
        format.json { render json: @delaytask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delaytasks/1
  # DELETE /delaytasks/1.json
  def destroy
    @delaytask.destroy
    respond_to do |format|
      format.html { redirect_to delaytasks_url, notice: 'Delaytask was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delaytask
      @delaytask = Delaytask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delaytask_params
      params.require(:delaytask).permit(:app, :crontab, :apptype, :mailto ,:name ,:server ,:env)
    end
end
