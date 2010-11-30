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
      , "script")

      false
    )

jQuery(() ->

  # Build and run code according to what page we're on
  if $(".raid").length > 0
    new Raid()

)
