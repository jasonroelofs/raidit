class @GuildSelect
  constructor: (@element) ->
    @element.select2(
      width: "element"
      placeholder: "Select or search for a guild"
    )

