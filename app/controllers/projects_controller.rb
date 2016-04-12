class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :verify_tenant

  # GET /projects
  # GET /projects.json
  def index
    @tenant = Tenant.current_tenant
    @projects = Project.by_user_plan_and_tenant(@tenant.id)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tenant = Tenant.current_tenant
  end

  # GET /projects/new
  def new
    @project = Project.new
    @tenant = Tenant.current_tenant
  end

  # GET /projects/1/edit
  def edit
    @tenant = Tenant.current_tenant
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @tenant = Tenant.current_tenant

    respond_to do |format|
      if @project.save
        format.html { redirect_to tenant_project_path(@project, tenant_id: @tenant.id), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to tenant_project_path(@project, tenant_id: @tenant.id), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @tenant = Tenant.current_tenant
    @project.destroy
    respond_to do |format|
      format.html { redirect_to tenant_projects_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :details, :expected_completion_date, :tenant_id, :invoice_number)
    end

    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
    end

    def verify_tenant
      unless params[:tenant_id] == Tenant.current_tenant_id.to_s
        redirect_to user_dashboard_path, flash: {error: 'You are not authorized to access any organization other than your own'}
      end
    end



end
