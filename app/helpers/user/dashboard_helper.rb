module User::DashboardHelper
  def task_day_unq_class task, day
    "task_#{task.id}_note_#{day.strftime('%d_%m')}"
  end

  def progress_class(a_prg, t_prg)
    if a_prg.to_i >= t_prg.to_i
      'success'
    elsif t_prg.to_i - a_prg.to_i <= 10
      'warning'
    else
      'danger'
    end
  end

  def status_class(status)
    case status
    when 'not_started'
      'closed'
    when 'delay'
      'danger'
    when 'finished'
      'success'
    end
  end
end
