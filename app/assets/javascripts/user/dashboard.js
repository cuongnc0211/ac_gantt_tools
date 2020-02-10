$(document).on('turbolinks:load', function() {
  if($(".scrollable").length > 0) {
    $('.scrollable').animate({scrollLeft: $('#today-anchor').position().left -900});
  }

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
  $(document).on('click', '.task_show_modal', function(e){
    e.preventDefault();

    var form = $("#task-detail-modal").find("form");
    var token = $("meta[name='csrf-token']").attr('content');
    form.find("input[name='authenticity_token']").val(token);

    var task_id = $(this).closest("tr").data("task-id")
    $.ajax({
      async : true,
      type : "GET",
      url : '/user/tasks/' + task_id + '/modal_task_detail'
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

  $(".select-parent-id").select2({});

  $(document).on("change", ".select_task_type", function(){    
    var task_type = $(this).val()
    $.ajax({
      async : true,
      type : "GET",
      url : "/user/tasks/possible_parent_tasks.json",
      dataType : "json",
      data: {
        type: task_type
      },
      success : function(res) {
        // createJSTrees(res.data);
        if(res['data'].length > 0){
          var rendered_html = ""
          for (key in res['data']) {
            rendered_html += ('<option value="' + res['data'][key][1] + '">' + res['data'][key][0] + '</option>');
          }
          $(".select-parent-id").html(rendered_html);
          $(".select-parent-id").select2({});
        }
      },
      error : function(xhr, ajaxOptions, thrownError) {
        alert(xhr.status);
        alert(thrownError);
      }
    });
  });
});

//function handle merge cells table
function mergeCellTable(task_id){
  var container = '.task-' + task_id + ' .task_' + task_id + '_progess_dates'
  $(container).each(function(index){
    if(index == 0) {
      var length = $(container).length
      $(this).attr('colspan', length);
    } else {
      $(this).remove();
    }
  });
}
