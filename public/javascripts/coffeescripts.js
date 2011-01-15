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
    $(".actions .main").mouseenter(function() {
      var actions;
      actions = $(this).parents(".actions");
      actions.find(".all").show();
      return false;
    });
    $(".actions .all").mouseleave(function() {
      var actions;
      actions = $(this).parents(".actions");
      actions.find(".all").hide();
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
    $(".actions a.note").live("click", function() {
      $("#add_notes_dialog").data("raidit.update_url", $(this).attr("href")).dialog("open");
      return false;
    });
    $("a.preset").live("click", function() {
      $("#raid_tanks").val($(this).attr("data-tanks"));
      $("#raid_healers").val($(this).attr("data-healers"));
      $("#raid_dps").val($(this).attr("data-dps"));
      return false;
    });
    $("a.has_notes").each(function() {
      return $(this).qtip({
        content: $(this).siblings(".notes"),
        position: {
          at: "bottom center"
        }
      });
    });
    $("#add_notes_dialog").dialog({
      autoOpen: false,
      title: "Add Note",
      modal: true,
      draggable: false,
      resizable: false,
      width: "450px",
      position: "center",
      buttons: {
        "Cancel": function() {
          return $(this).dialog("close");
        },
        "Add Note": function() {
          var dialog, href, val;
          href = $(this).data("raidit.update_url");
          val = $(this).find("textarea").val();
          dialog = $(this);
          return $.get(href, {
            note: val
          }, function() {
            return dialog.dialog("close");
          });
        }
      }
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
    $("table.tablesorter").each(function() {
      var defaultSorting, headers, options, sorting, table;
      table = $(this);
      defaultSorting = table.attr("data-default");
      headers = {};
      options = {};
      if (defaultSorting) {
        sorting = defaultSorting.split(",");
        options.sortList = [sorting];
      }
      table.find("tr th").each(function(index, element) {
        return $(this).hasClass("nosort") ? (headers[index] = {
          sorter: false
        }) : null;
      });
      options.headers = headers;
      return table.tablesorter(options);
    });
    return $("a[title]").qtip({
      position: {
        at: "bottom center"
      }
    });
  });
}).call(this);
