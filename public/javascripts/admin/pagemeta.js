function addAttribute(form) {
  if (validAttributeName()) {
    new Ajax.Updater(
      $('attributes').down('tbody'),
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
    row.down('.delete_input').setValue(true);
    row.down('.page_meta_name').clear();
    row.hide();
  }
}
function attributeAdded(element) {
  $(element).previous('.busy').hide();
  $(element).down('.button').enable();
  $(element).up('.popup').closePopup();
  $('page_meta_counter').setValue(Number($('page_meta_counter').value).succ);
  $('new_page_meta').reset();
}
function attributeLoading(element) {
  $(element).down('.button').disable();
  $(element).previous('.busy').appear();
}
function validAttributeName() {
  var metaNameField = $('page_meta_name');
  var name = metaNameField.value.downcase();
  if (name.blank()) {
    alert('Attribute name cannot be empty.');
    return false;
  }
  if (findMetaByName(name)) {
    alert('Attribute name must be unique.');
    return false;
  }
  return true;
}
function findMetaByName(name) {
  return $('attributes').select('input.page_meta_name').detect(function(input) { return input.value.downcase() == name });
}