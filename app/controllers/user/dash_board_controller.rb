class User::DashBoardController < User::BaseController
  def index
    load_dates
    @projects = Project.all
    @tasks = Task.in_quater(@start_date, @end_date)
  end

  def home
  end
end
