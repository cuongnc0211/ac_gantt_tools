class Task < ApplicationRecord
  before_save :set_type, :recalculate_working_days

  belongs_to :project
  belongs_to :member, optional: true
  has_many :sub_tasks, class_name: 'SubTask', foreign_key: 'parent_id'
  has_many :activities, through: :sub_tasks
  has_many :task_notes

  delegate :color, to: :member, prefix: true, allow_nil: true

  enum status: { not_started: 0, in_progress: 1, finished: 2, delay: 3 }

  START_DATE = Date.today.beginning_of_quarter
  END_DATE   = Date.today.end_of_quarter

  scope :in_quater, -> (start_date, end_date) {
    where(start_date: start_date..end_date)
  }

  scope :quater, -> {
    where(start_date: START_DATE..END_DATE)
  }

  def childrent
    self.sub_tasks + self.activities
  end

  def show_title
    if note.present?
      "<i class='fa fa-book' style='font-size: 11px; color: red;'></i>" + title.truncate(22)
    else
      title.truncate(22)
    end
  end

  def avg_parent_prg
    chilrent = self.childrent
    return actual_progress if ( self.type != 'Task' || chilrent.blank?)

    chilrent.pluck(:actual_progress).sum / chilrent.count
  end

  def update_parent_date
    return if self.type == 'Task'

    parent    = self.root_parent
    childrent = parent.childrent
    soonest   = childrent.sort_by {|c| c.start_date}.first
    latest    = childrent.sort_by {|c| c.end_date}.last

    parent.start_date = soonest.start_date
    parent.end_date = latest.end_date
    parent.save
    parent
  end

  def self.types
    %w[Task SubTask Activity]
  end

  def possible_parent_tasks
    case self.type
    when "Task"
      return []
    when "SubTask"
     Task.where(type: :Task).quater
    when "Activity"
      SubTask.all.quater
    when nil
      Task.where.not(type: 'Activity').quater
    end
  end

  def include_date?(date)
    (start_date..(end_date + 1.day)).cover? date
  end

  def marking?(date)
    include_date?(date)
  end

  def target_progress
    # return 0 if not_cal_statistic?
    return 100 if finished? || end_date < Date.today

    percent = (Task.working_days start_date, Date.today).to_f / working_days.to_f * 100
    percent.round(0)
  end

  def target_day_to_do
    return 0 if Date.today > end_date

    working_days - Task.working_days(start_date, Date.today)
  end

  def actual_days_to_do
    return 0 if not_cal_statistic? || end_date < Date.today

    worked_days = Task.working_days(start_date, Date.today)
    avg_v = actual_progress / worked_days
    100 / avg_v - worked_days
  rescue StandardError
    return 0
  end

  def actual_finished_date
    Task.working_target_date(actual_days_to_do, Date.today)
  end

  def actual_worked_days
    return Task.working_days(start_date, finished_date) if finished?

    Task.working_days(start_date, Date.today)
  end

  # ===========================================================================
  # view method

  def class_to_merge(date)
    if include_date?(date)
      return ""
    end
  end


  # ===========================================================================

  def self.working_days(start_date, end_date)
    days = 0
    return if start_date.nil? || end_date.nil?

    start_date.to_date.upto(end_date.to_date) do |d|
      # next if d.saturday? || d.sunday?

      days += 1
    end
    days
  end

  def self.working_target_date(days, start_date)
    i = 1
    date = start_date

    while i <= days
      next if start_date.saturday? || start_date.sunday?

      date += 1.day
      i += 1
    end
    date
  end

  private

  def set_type
    self.type = 'Task'
  end

  def recalculate_working_days
    self.working_days = Task.working_days(start_date, end_date)
  end

  def not_cal_statistic?
    not_started? || delay?
  end
end
