//= require jquery

function remove_field(link, type) {
  var removeButton = type === 'simple'? $(link) : $(link).parent('div');
  var hiddenInput = removeButton.prev('input[type=hidden]');
  hiddenInput.val('true');
  removeButton.parent().hide();
}

function add_field(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g');
  $(link).parent().before(content.replace(regexp, new_id));
}

function updateQuestionType(selectElement, type) {
  var parentElement = $(selectElement).parent();

  if (type === 'single') {
    parentElement.find('.answer-fields').hide();
    parentElement.find('.add-answer-link').hide();
  } else if (type === 'poll') {
    parentElement.find('.answer-fields').show();
    parentElement.find('.add-answer-link').show();
    parentElement.find('.check-box').removeClass('show').addClass('hide');
  } else {
    parentElement.find('.answer-fields').show();
    parentElement.find('.add-answer-link').show();
    parentElement.find('.check-box').removeClass('hide').addClass('show');
  }
};