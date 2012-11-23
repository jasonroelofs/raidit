class @SignupDetails
  constructor: (@element) ->
    @element.qtip
      content:
        text: "Loading..."
        ajax:
          url: @element.attr("data-url")
      position:
        at: "bottom center"
        my: "top center"
      show:
        event: 'click'
      hide:
        event: 'click'
      style:
        classes: 'ui-tooltip-shadow ui-tooltip-light'
