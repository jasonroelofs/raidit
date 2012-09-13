class @CharacterSelect
  constructor: (@element) ->
    @element.select2(
      width: "element"
      formatResult: @formatCharacter
      formatSelection: @formatCharacter
    )

  formatCharacter: (character) ->
    "<img src='/assets/wow/#{character.id}.png' class='class-icon-small'> #{character.text}"

