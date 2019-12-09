class User::TaskNotesController < User::BaseController
  def create
    @task_note = TaskNote.create task_note_params
    @task = @task_note.task
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    @task_note = TaskNote.find_by id: params[:id]
    @task = @task_note.task
    @task_note.update_attributes task_note_params

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
  def task_note_params
    params.require(:task_note).permit :task_id, :content, :date
  end
end
