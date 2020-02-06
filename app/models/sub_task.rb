class SubTask < Task
  before_save :set_type

  belongs_to :task, class_name: "Task", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Task", foreign_key: "parent_id"
  has_many :activities, class_name: "Activity", foreign_key: "parent_id"

  def root_parent
    self.parent
  end

  private

  def set_type
    self.type = "SubTask"
  end
end
