class User::TasksController < User::BaseController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  # GET /user/tasks
  # GET /user/tasks.json
  def index
    @projects = Project.all.includes(tasks: [:member, sub_tasks: [:member, activities: :member]])
  end

  # GET /user/tasks/1
  # GET /user/tasks/1.json
  def show
  end

  # GET /user/tasks/new
  def new
    @task = Task.new
  end

  # GET /user/tasks/1/edit
  def edit
  end

  # POST /user/tasks
  # POST /user/tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_task_path(@task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/tasks/1
  # PATCH/PUT /user/tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_task_path(@task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/tasks/1
  # DELETE /user/tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :description, :start_date, :end_date,
      :working_days, :project_id, :type, :parent_id, :member_id, :type,
      :parent_id, :actual_progress, :status, :finished_date)
  end
end
