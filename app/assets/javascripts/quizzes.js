//= require jquery

function remove_fields(link) {
  console.log('remove fields called with');
  $(link).prev("input[type=hidden]").value = "1";
  $(link).parent(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}