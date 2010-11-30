(function() {
  var Raid;
  Raid = function() {
    $(".queue_another").live("click", function() {
      $("#queue_main").slideUp();
      $("#queue_form").slideDown();
      return false;
    });
    $(".actions a.accept").live("click", function() {
      var actions, href;
      href = $(this).attr("href");
      actions = $(this).parents(".actions");
      $.get(href, {}, function(data) {
        actions.html(data);
        return $(".changes_made").show();
      }, "script");
      return false;
    });
    return this;
  };
  jQuery(function() {
    return $(".raid").length > 0 ? new Raid() : null;
  });
})();
