module User::DashboardHelper
  def task_day_unq_class task, day
    "task_#{task.id}_note_#{day.strftime('%d_%m')}"
  end
end
