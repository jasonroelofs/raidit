//= require jquery
//= require select2
//= require_tree .

$(function() {
  $(".guild-select").each(function(i, e) {
    new GuildSelect($(e));
  });

  $(".character-select").each(function(i, e) {
    new CharacterSelect($(e));
  });
});
