$(document).on('turbolinks:load', function() {
  $(document).on("change", ".intable-form input", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });

  $(document).on("change", ".intable-form select", function(){
    $(this).closest("form").find(".intable-form-submit").click();
  });
});
