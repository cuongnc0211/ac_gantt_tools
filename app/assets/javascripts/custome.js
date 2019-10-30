$(document).on('turbolinks:load', function() {
  $('.color-picker').minicolors({theme: 'bootstrap'});

  $('.datepicker').datepicker({
    autoclose: true,
    dateFormat: "dd MM, yy",
    todayBtn: true,
    todayHighlight: true,
    changeMonth: true,
    changeYear: true
  });
});
