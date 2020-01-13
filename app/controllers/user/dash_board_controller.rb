class User::DashBoardController < User::BaseController
  def index
    @task = Task.first
    @projects = Project.all.includes(tasks: [:member, sub_tasks: [:member, activities: :member]])
    load_dates
  end
end
