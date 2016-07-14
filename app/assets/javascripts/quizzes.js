//= require jquery

function remove_fields(link) {
  var removeButton = $(link).parent("div");
  var hiddenInput = removeButton.prev("input[type=hidden]");
  var questionLabel = hiddenInput.prev("label");
  var questionTextarea = removeButton.next("textarea");

  hiddenInput.val("true");
  removeButton.hide();
  questionLabel.hide();
  questionTextarea.hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}