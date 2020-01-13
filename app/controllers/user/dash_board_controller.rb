class User::DashBoardController < User::BaseController
  def index
    @task = Task.first
    load_dates
    @projects = Project.all
    @tasks = Task.in_quater(@start_date, @end_date)
  end
end
