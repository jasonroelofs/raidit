class @CustomSelect
  constructor: (@element) ->
    @element.select2()

    @element.data("select2").container.find(".select2-search").hide()
