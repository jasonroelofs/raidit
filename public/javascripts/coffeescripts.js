(function() {
  var Characters, Raid;
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
  Characters = function() {
    var self;
    self = this;
    $("#name").live("keyup", function() {
      return self.setTimer();
    });
    return this;
  };
  Characters.prototype.timer = null;
  Characters.prototype.setTimer = function() {
    var self, timer;
    if (!timer) {
      self = this;
      return (timer = setTimeout(function() {
        return self.runQuery();
      }, 500));
    }
  };
  Characters.prototype.runQuery = function() {
    var href, name;
    href = $("#new_character").attr("action");
    name = $("#name").val();
    return name !== "" ? $.get(href, {
      name: name
    }, function(data) {
      return $("#characters").html(data);
    }) : null;
  };
  jQuery(function() {
    if ($(".raid").length > 0) {
      new Raid();
    }
    return $("#new_character").length > 0 ? new Characters() : null;
  });
})();
