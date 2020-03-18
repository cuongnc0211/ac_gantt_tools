class SubTaskSerializer < BaseSerializer
  attributes :id, :title, :description, :start_date, :end_date, :project_id,
    :type, :parent_id, :actual_progress, :status, :finished_date, :note, :childrent

  def childrent
    ActiveModel::SerializableResource.new(
      object.activities.in_quater(start_date, end_date),
      each_serializer: ActivitySerializer
    )
  end
end
