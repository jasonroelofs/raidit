class Raid
  constructor: ->
    $(".queue_another").live("click", () ->
      $("#queue_main").slideUp()
      $("#queue_form").slideDown()
      false
    )

    $(".actions .main").mouseenter( () ->
      actions = $(this).parents(".actions")
      actions.find(".all").show()
      false
    )
    $(".actions .all").mouseleave( () ->
      actions = $(this).parents(".actions")
      actions.find(".all").hide()
      false
    )

    # Ajax update for acceptance to allow for
    # quick run through a list
    $(".actions a.accept").live("click", () ->
      href = $(this).attr("href")
      actions = $(this).parents(".actions")

      $.get(href, {}, (data) ->
        actions.html(data)
        $(".changes_made").show()
      , "script")

      false
    )

    $(".actions a.note").live("click", () ->
      $("#add_notes_dialog").data("raidit.update_url", $(this).attr("href")).dialog("open")
      false
    )

    $("a.preset").live("click", () ->
      $("#raid_tanks").val($(this).attr("data-tanks"))
      $("#raid_healers").val($(this).attr("data-healers"))
      $("#raid_dps").val($(this).attr("data-dps"))

      false
    )

    $("a.has_notes").each( () ->
      $(this).qtip({
        content: $(this).siblings(".notes"),
        position: {
          at: "bottom center"
        }
      })
    )

    $("#add_notes_dialog").dialog({
      autoOpen: false,
      title: "Add Note",
      modal: true,
      draggable: false,
      resizable: false,
      width: "450px",
      position: "center",
      buttons: {
        "Cancel" : () ->
          $(this).dialog("close")
        ,"Add Note": () ->
          href = $(this).data("raidit.update_url")
          val = $(this).find("textarea").val()
          dialog = $(this)
          $.get(href, {note: val}, () ->
            dialog.dialog("close")
          )
      }
    })

class Characters
  constructor: ->
    @timer = null
    $("#name").live("keyup", () =>
      @setTimer()
    )

  setTimer: ->
    if @timer
      clearTimeout(@timer)

    @timer = setTimeout(() =>
      @runQuery()
    , 300)

  runQuery: ->
    href = $("#new_character").attr("action")
    name = $("#name").val()
    @timer = null

    if name != ""
      $.get(href, {name: name}, (data) ->
        $("#characters").html(data)
      )

jQuery(() ->

  # Build and run code according to what page we're on
  if $(".raid").length > 0
    new Raid()

  if $("#new_character").length > 0
    new Characters()

  # Set up tablesorter
  $("table.tablesorter").each( ->
    table = $(this)
    defaultSorting = table.attr("data-default")
    headers = {}
    options = {}

    if defaultSorting
      sorting = defaultSorting.split(",")
      options.sortList = [ sorting ]

    table.find("tr th").each( (index, element) ->
      if $(this).hasClass("nosort")
        headers[index] = {sorter: false}
    )

    options.headers = headers

    table.tablesorter(options)
  )

  # Any link with a title attribute gets qtip'd
  $("a[title]").qtip({
    position: {
      at: "bottom center"
    }
  })
)
