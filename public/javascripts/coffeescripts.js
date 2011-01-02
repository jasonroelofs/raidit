(function() {
  var Characters, Raid;
  var __bind = function(func, context) {
    return function(){ return func.apply(context, arguments); };
  };
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
    $("a.preset").live("click", function() {
      $("#raid_tanks").val($(this).attr("data-tanks"));
      $("#raid_healers").val($(this).attr("data-healers"));
      $("#raid_dps").val($(this).attr("data-dps"));
      return false;
    });
    return this;
  };
  Characters = function() {
    this.timer = null;
    $("#name").live("keyup", __bind(function() {
      return this.setTimer();
    }, this));
    return this;
  };
  Characters.prototype.setTimer = function() {
    if (this.timer) {
      clearTimeout(this.timer);
    }
    return (this.timer = setTimeout(__bind(function() {
      return this.runQuery();
    }, this), 300));
  };
  Characters.prototype.runQuery = function() {
    var href, name;
    href = $("#new_character").attr("action");
    name = $("#name").val();
    this.timer = null;
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
    if ($("#new_character").length > 0) {
      new Characters();
    }
    return $("table.tablesorter").each(function() {
      var defaultSorting, headers, table;
      table = $(this);
      defaultSorting = table.attr("data-default").split(",");
      headers = {};
      table.find("tr th").each(function(index, element) {
        return $(this).hasClass("nosort") ? (headers[index] = {
          sorter: false
        }) : null;
      });
      return table.tablesorter({
        sortList: [defaultSorting],
        headers: headers
      });
    });
  });
}).call(this);
