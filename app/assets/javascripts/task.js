$(document).on('turbolinks:load', function() {
  $(".task-end-date").on("change", function(){
    if($(".task-start-date").val().length > 0){
      var workingDays = countWorkingDays();
      $(".task-working-day").val(workingDays);
    }
  });

  $(".task-working-day").on("change", function(){
    if($(".task-start-date").val().length > 0){
      var day = countEndDate();
      $(".task-end-date").datepicker("setDate", day);
    }
  });
});

function countWorkingDays(){
  var initial_time = new Date($(".task-start-date").val());
  var end_time = new Date($(".task-end-date").val());
  var working_days = 0;

  for (var day = initial_time; day <= end_time; day.setDate(day.getDate() + 1)) {
    if(day.getDay() != 6 && day.getDay() != 0){
      working_days += 1
    }
  }
  return working_days;
}

function countEndDate(){
  var working_days = parseInt($(".task-working-day").val());
  var day = new Date($(".task-start-date").val());
  var i = 1

  do {
    day.setDate(day.getDate() + 1)
    if(day.getDay() != 6 && day.getDay() != 0){
      i++;
    }
  }
  while (i < working_days);

  return $.datepicker.formatDate("dd MM, yy", day);
}
