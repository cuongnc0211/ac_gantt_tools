class User::TasksController < User::BaseController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_date_period
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
        format.html { redirect_to user_tasks_path, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
      format.js {render layout: false}
    end
  end

  # PATCH/PUT /user/tasks/1
  # PATCH/PUT /user/tasks/1.json
  def update
    @start_date = Date.today.beginning_of_quarter
    @end_date = Date.today.end_of_quarter
    @project = @task.project
    respond_to do |format|
      if @task.update(task_params)
        @parent_task = @task.update_parent_date
        format.html { redirect_to user_tasks_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
      format.js {render layout: false}
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

  def modal_task_detail
    @task = Task.find(params[:id])

    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def possible_parent_tasks
    @tasks = Task.new(type: params[:type]).possible_parent_tasks
    data = @tasks.map do |i|
      [i.title, i.id]
    end

    render json: {data: data}
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def set_date_period
    @start_date ||= Date.today.beginning_of_quarter
    @end_date ||= Date.today.end_of_quarter
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    name = nil
    [:task, :sub_task, :activity].each do |t|
      name = t if params.dig(t).present?
    end

    params.require(name.to_sym).permit(:title, :description, :start_date, :end_date,
      :working_days, :project_id, :type, :parent_id, :member_id, :type,
      :parent_id, :actual_progress, :status, :finished_date, :note)
  end
end
