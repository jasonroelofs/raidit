class @CharacterSelect
  constructor: (@element) ->
    @element.select2(
      formatResult: @formatCharacter
      formatSelection: @formatCharacter
    )

  formatCharacter: (character) ->
    char_class =
      if character.element
        $(character.element).data("character-class")
      else
        character.id

    "<img src='/assets/wow/#{char_class}.png' class='class-icon class-icon-small'> #{character.text}"

