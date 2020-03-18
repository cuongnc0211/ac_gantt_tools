class ProjectSerializer < BaseSerializer
  attributes :id, :name, :description

  has_many :tasks

  def tasks
    object.tasks.in_quater(start_date, end_date)
  end
end
