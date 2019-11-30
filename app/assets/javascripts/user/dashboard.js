$(document).on('turbolinks:load', function() {
  $(document).on("change", ".intable-form input", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });

  $(document).on("change", ".intable-form select", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });

  //trigger popover by hover anf delay 300ms
  $('[data-toggle="popover"]').popover({
    trigger: 'manual',
    html: true,
    animation: false
  })
  .on('mouseenter', function () {
    var _this = this;
    $('.popover').popover('hide')
    $(this).popover('show');
    $('.popover').on('mouseleave', function () {
      $(_this).popover('hide');
    }, 500);
  }).on('mouseleave', function () {
    var _this = this;
    setTimeout(function () {
      if (!$('.popover:hover').length) {
        $(_this).popover('hide');
      }
    }, 300);
  });

  // $('[data-toggle="popover"]').popover({ trigger: "click" });
  // $(document).on("click", "[data-toggle='popover']", function(e){
  //   var template = $(this).data("content");

  //   $(this).popover({
  //     html: true,
  //     content: template,
  //   });
  // });

  // $('body').on('click', function (e) {
  //   $('[data-toggle="popover"]').each(function () {
  //     //the 'is' for buttons that trigger popups
  //     //the 'has' for icons within a button that triggers a popup
  //     if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
  //         $(this).popover('hide');
  //     }
  //   });
  // });

  $(document).on("click", ".modify_task_note", function(e){
    e.preventDefault();
    $(".popover").popover('hide');
    $("#task-note-modal").modal("show");
  });
});
