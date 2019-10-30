class User::ProjectsController < User::BaseController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /user/projects
  # GET /user/projects.json
  def index
    @projects = Project.all
  end

  # GET /user/projects/1
  # GET /user/projects/1.json
  def show
  end

  # GET /user/projects/new
  def new
    @project = Project.new
  end

  # GET /user/projects/1/edit
  def edit
  end

  # POST /user/projects
  # POST /user/projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to user_project_path(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/projects/1
  # PATCH/PUT /user/projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to user_project_path(@project), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/projects/1
  # DELETE /user/projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to user_projects_url, notice: 'Project was successfully destroyed.' }
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
      params.require(:project).permit :name, :description
    end
end
