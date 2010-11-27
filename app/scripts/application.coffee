class Raid
  constructor: ->
    $(".queue_another").live("click", () ->
      $("#queue_main").slideUp()
      $("#queue_form").slideDown()
      false
    )

jQuery(() ->

  # Build and run code according to what page we're on
  if $(".raid").length > 0
    new Raid()
)
