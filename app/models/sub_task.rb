class SubTask < Task
  before_save :set_type

  belongs_to :task, class_name: "Task", foreign_key: "parent_id"
  has_many :activities, class_name: "Activity", foreign_key: "parent_id"

  private

  def set_type
    self.type = "SubTask"
  end
end
