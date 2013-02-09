window.Mercury.Custom = {};
window.Mercury.Custom.change_jumbotron_background = function(obj) {
  var style = 'background: url(';
  style += obj.selectedOptions[0].value;
  style += ') no-repeat bottom left;';
  $('#page_jumbotron_style').val(style);
};
