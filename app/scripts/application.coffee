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

class Characters
  timer: null

  constructor: ->
    self = this
    $("#name").live("keyup", () ->
      self.setTimer()
    )

  setTimer: ->
    if !timer
      self = this
      timer = setTimeout(() ->
        self.runQuery()
      , 500)

  runQuery: ->
    href = $("#new_character").attr("action")
    name = $("#name").val()

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

)
