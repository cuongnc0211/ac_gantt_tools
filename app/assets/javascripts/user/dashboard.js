$(document).on('turbolinks:load', function() {
  $(document).on("change", ".intable-form input", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });

  $(document).on("change", ".intable-form select", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });
  
  //handle merge pregress cells
  $('.task-row').each(function(){
    var task_id = $(this).data('task-id')
    mergeCellTable(task_id);
  });

  // hande click on task_progess_dates
  $(document).on('click', '.task_progess_dates a', function(e){
    e.preventDefault();

    var form = $("#task-detail-modal").find("form");
    var token = $("meta[name='csrf-token']").attr('content');
    form.find("input[name='authenticity_token']").val(token);

    var task_id = $(this).closest("tr").data("task-id")
    $.ajax({
      async : true,
      type : "GET",
      url : `/user/tasks/${task_id}/modal_task_detail`
    }).done(function() {
      $('.datepicker').datepicker({
        autoclose: true,
        dateFormat: "dd MM, yy",
        todayBtn: true,
        todayHighlight: true,
        changeMonth: true,
        changeYear: true
      });
    });

    $("#task-detail-modal").modal("show");
  });

  $('.datepicker').datepicker({
    autoclose: true,
    dateFormat: "dd MM, yy",
    todayBtn: true,
    todayHighlight: true,
    changeMonth: true,
    changeYear: true
  });

  //handle show new task modal
  $(document).on('click', '.dashboard-add-task', function(e){
    $("#new_task #task_project_id").val($(this).data('project-id'));
    $("#new_task #task_parent_id").val($(this).data('task-id'));
    $("#new_task #task_type").val($(this).data('task-type'));
    $("#new_task #task_working_days").val(1);

    $("#new-task-modal").modal("show");
  });
});

//function handle merge cells table
function mergeCellTable(task_id){
  $(`.task-${task_id} .task_${task_id}_progess_dates`).each(function(index){
    if(index == 0) {
      $(this).attr('colspan', $(`.task-${task_id} .task_${task_id}_progess_dates`).length);
    } else {
      $(this).remove();
    }
  });
}
