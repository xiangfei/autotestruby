class EmailgroupsController < ApplicationController
  before_action :set_emailgroup, only: [:show, :edit, :update, :destroy]

  # GET /emailgroups
  # GET /emailgroups.json
  def index
    @q = Emailgroup.ransack(params[:q])

    @emailgroups = @q.result.page(params[:page])
  end

  # GET /emailgroups/1
  # GET /emailgroups/1.json
  def show
  end

  # GET /emailgroups/new
  def new
    @emails = Email.all
    @emailgroup = Emailgroup.new
  end

  # GET /emailgroups/1/edit
  def edit
  end

  # POST /emailgroups
  # POST /emailgroups.json
  def create
    @emailgroup = Emailgroup.new(emailgroup_params)
    email_id_list = params[:emailgroup][:email_ids]
    respond_to do |format|
      Emailgroup.transaction do
        if @emailgroup.save
          if email_id_list
            email_id_list.each do |email_id|
              if not email_id.empty?
                eg = EmailGroupAndEmail.new
                eg.email_id = email_id
                eg.emailgroup_id = @emailgroup.id
                eg.save!
              end
            end
          end
          format.html { redirect_to @emailgroup, notice: "Emailgroup was successfully created." }
          format.json { render :show, status: :created, location: @emailgroup }
        else
          format.html { render :new }
          format.json { render json: @emailgroup.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /emailgroups/1
  # PATCH/PUT /emailgroups/1.json
  def update
    respond_to do |format|
      Emailgroup.transaction do
        if @emailgroup.update(emailgroup_params)
          email_id_list = params[:emailgroup][:email_ids]
          if email_id_list
            @emailgroup.emails.destroy_all
            email_id_list.each do |email_id|
              if not email_id.empty?
                eg = EmailGroupAndEmail.new
                eg.email_id = email_id
                eg.emailgroup_id = @emailgroup.id
                eg.save!
              end
            end
          end

          format.html { redirect_to @emailgroup, notice: "Emailgroup was successfully updated." }
          format.json { render :show, status: :ok, location: @emailgroup }
        else
          format.html { render :edit }
          format.json { render json: @emailgroup.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /emailgroups/1
  # DELETE /emailgroups/1.json
  def destroy
    @emailgroup.destroy
    respond_to do |format|
      format.html { redirect_to emailgroups_url, notice: "Emailgroup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_emailgroup
    @emailgroup = Emailgroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def emailgroup_params
    params.require(:emailgroup).permit(:name ,:appname)
  end
end
