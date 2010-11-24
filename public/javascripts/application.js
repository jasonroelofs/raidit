$(function() {
  $(".queue_another").live("click", function() {
    $("#queue_main").slideUp();
    $("#queue_form").slideDown();
  });
});
