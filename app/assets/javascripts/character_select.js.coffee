class @CharacterSelect
  constructor: (@element) ->
    @element.select2(
      formatResult: @formatCharacter
      formatSelection: @formatCharacter
    )

    @element.data("select2").container.find(".select2-search").hide()

  formatCharacter: (character) ->
    char_class =
      if character.element
        $(character.element).data("character-class")
      else
        @element.find("option:selected").attr("data-character-class")

    "<img src='/assets/wow/#{char_class}.png' class='class-icon class-icon-small'> #{character.text}"

