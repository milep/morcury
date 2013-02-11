window.Mercury.Page = {};
window.Mercury.Page.change_jumbotron_background = function(obj) {
  var style = 'background: url(';
  style += obj.selectedOptions[0].value;
  style += ') no-repeat bottom left;';
  $('#page_jumbotron_style').val(style);
};

window.Mercury.Page.moveUp = function(id) {
  console.debug('id: %o', id);
};

window.Mercury.Page.moveDown = function(id) {
  console.debug('id: %o', id);
};
