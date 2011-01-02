class Raid
  constructor: ->
    $(".queue_another").live("click", () ->
      $("#queue_main").slideUp()
      $("#queue_form").slideDown()
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

    $("a.preset").live("click", () ->
      $("#raid_tanks").val($(this).attr("data-tanks"))
      $("#raid_healers").val($(this).attr("data-healers"))
      $("#raid_dps").val($(this).attr("data-dps"))

      false
    )

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
    defaultSorting = table.attr("data-default").split(",")
    headers = {}

    table.find("tr th").each( (index, element) ->
      if $(this).hasClass("nosort")
        headers[index] = {sorter: false}
    )

    table.tablesorter({
      sortList: [ defaultSorting ],
      headers: headers
    })
  )
)
