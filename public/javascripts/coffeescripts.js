(function() {
  var Raid;
  Raid = function() {
    $(".queue_another").live("click", function() {
      $("#queue_main").slideUp();
      $("#queue_form").slideDown();
      return false;
    });
    return this;
  };
  jQuery(function() {
    return $(".raid").length > 0 ? new Raid() : null;
  });
})();
