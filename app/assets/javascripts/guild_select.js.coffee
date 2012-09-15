class @GuildSelect

  constructor: (@element) ->
    @element.select2(
      formatResult: @formatGuildResult
      formatSelection: @formatGuildSelection
      minimumInputLength: 3
      ajax:
        url: "/guilds.json"
        dataType: "json"
        data: (term) ->
          q: term

        results: @processGuilds
    )

    @element.on "change", @checkIfAddGuildSelected

  processGuilds: (data, page) ->
    data.push({name: "", id: null})
    data.push({name: "[Add Your Guild]", id: "new_guild" })

    { results: data }

  formatGuildResult: (guild) ->
    guild.name

  formatGuildSelection: (guild) ->
    guild.name

  checkIfAddGuildSelected: () ->
    if $(this).val() == "new_guild"
      $(".add-guild").slideDown()
      $("#character_guild_region").focus()
    else
      $(".add-guild").slideUp()
