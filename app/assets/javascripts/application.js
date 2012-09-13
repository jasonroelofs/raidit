//= require jquery
//= require select2
//= require_tree .

$(function() {
  $.fn.select2.defaults.width = "element";

  $(".character-select").each(function(i, e) {
    new CharacterSelect($(e));
  });

  $("select:not(.character-select)").each(function(i, e) {
    new CustomSelect($(e));
  });
});
