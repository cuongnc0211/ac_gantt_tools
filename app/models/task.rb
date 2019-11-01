class Task < ApplicationRecord
  before_save :set_type

  belongs_to :project
  belongs_to :member
  has_many :sub_tasks, class_name: 'SubTask', foreign_key: 'parent_id'

  delegate :color, to: :member, prefix: true, allow_nil: true

  enum status: { not_started: 0, in_progress: 1, finished: 2, delay: 3 }

  def self.types
    %w[Task SubTask Activity]
  end

  def include_date?(date)
    (start_date..(end_date + 1.day)).cover? date
  end

  def marking?(date)
    include_date?(date) && !(date.saturday? || date.sunday?)
  end

  def target_progress
    return 0 if not_cal_statistic?
    return 100 if finished? || end_date < Date.today

    (Task.working_days start_date, Date.today) / working_days * 100
  end

  def target_day_to_do
    return 0 if Date.today > end_date

    days - Task.working_days(start_date, Date.today)
  end

  def actual_days_to_do
    return 0 if not_cal_statistic? || end_date < Date.today

    worked_days = Task.working_days(start_date, Date.today)
    avg_v = actual_progress / worked_days
    100 / avg_v - worked_days
  end

  def actual_finished_date
    Task.working_target_date(actual_days_to_do, Date.today)
  end

  def actual_worked_days
    return Task.working_days(start_date, finished_date) if finished?

    Task.working_days(start_date, Date.today)
  end

  # ===========================================================================

  def self.working_days(start_date, end_date)
    days = 0
    return if start_date.nil? || end_date.nil?

    start_date.to_date.upto(end_date.to_date) do |d|
      next if d.saturday? || d.sunday?

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

  def not_cal_statistic?
    not_started? || delay?
  end
end
