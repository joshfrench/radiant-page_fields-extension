function addAttribute(form) {
  if (validAttributeName()) {
    new Ajax.Updater(
      $('attributes').down('table'),
      '/admin/pages/meta/',
      {
        asynchronous: true,
        evalScripts: true,
        insertion: 'bottom',
        onComplete: function(response){ attributeAdded(form) },
        onLoading: function(request){ attributeLoading(form) },
        parameters: Form.serialize(form)
      }
    );
  }
}
function removeAttribute(button) {
  var row = $(button).up('tr');
  var name = row.down('label').innerHTML;
  if (confirm('Remove the "' + name + '" attribute?')) {
		var deleteInput = row.down('.delete_input');
		deleteInput.setValue('true');
		row.hide();
	}
}
function attributeAdded(element) {
  $(element).previous('.busy').hide();
  $(element).down('.button').enable();
  $(element).up('.popup').closePopup();
	$('meta_row_counter').setValue(Number($('meta_row_counter').value).succ);
}
function attributeLoading(element) {
  $(element).down('.button').disable();
  $(element).previous('.busy').appear();
}
function validAttributeName() {
  return true;
}