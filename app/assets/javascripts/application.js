//= require jquery
//= require select2
//= require bootstrap-dropdown
//= require jquery.qtip.js
//= require_tree .

$(function() {
  $.fn.select2.defaults.width = "element";

  $(".character-select").each(function(i, e) {
    new CharacterSelect($(e));
  });

  $(".guild-select").each(function(i, e) {
    new GuildSelect($(e));
  });

  $("select:not(.character-select):not(.guild-select)").each(function(i, e) {
    new CustomSelect($(e));
  });

  $(".raid .signup").each(function(i, e) {
    new SignupDetails($(e));
  });
});
