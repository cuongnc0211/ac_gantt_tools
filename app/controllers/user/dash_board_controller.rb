class User::DashBoardController < User::BaseController
  def index
    @projects = Project.all.includes(tasks: [:member, sub_tasks: [:member, activities: :member]])
    gon.push({
      projects: @projects
    })
  end

  private
  def current_quarter_months(date)
    quarters = [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]
    quarters[(date.month - 1) / 3]
  end
end
