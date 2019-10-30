class Task < ApplicationRecord
  before_save :set_type

  belongs_to :project
  belongs_to :member
  has_many :sub_tasks, class_name: "SubTask", foreign_key: "parent_id"

  def self.types
    %w(Task SubTask Activity)
  end

  private

  def set_type
    self.type = "Task"
  end
end
