class Activity < Task
  before_save :set_type

  belongs_to :sub_task, class_name: "SubTask", foreign_key: "parent_id"
  belongs_to :parent, class_name: "SubTask", foreign_key: "parent_id"

  private

  def set_type
    self.type = "Activity"
  end

  def update_parent_time
    task = self.parent&.parent
    return if task.blank?

    
  end
end
