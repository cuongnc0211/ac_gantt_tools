$(document).on('turbolinks:load', function() {
  $(document).on("change", ".intable-form input", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });

  $(document).on("change", ".intable-form select", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });

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
    });
  }).on('mouseleave', function () {
    var _this = this;
    setTimeout(function () {
      if (!$('.popover:hover').length) {
        $(_this).popover('hide');
      }
    }, 300);
  });
});
