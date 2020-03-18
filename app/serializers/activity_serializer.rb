class ActivitySerializer < BaseSerializer
  attributes :id, :title, :description, :start_date, :end_date, :project_id,
    :type, :parent_id, :actual_progress, :status, :finished_date, :note
end
