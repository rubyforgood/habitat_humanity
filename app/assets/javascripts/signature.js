//= require signature_pad
$( document ).ready(function() {
  var wrapper = document.getElementById("Signature"),
      clearButton = document.getElementById("clear"),
      saveButton = wrapper.querySelector("[data-action=save]"),
      canvas = wrapper.querySelector("canvas"),
      signaturePad;

  signaturePad = new SignaturePad(canvas);

  clearButton.addEventListener("click", function (event) {
      signaturePad.clear();
  });

  $('#new_check_in_form').submit(function(e) {
    if (signaturePad.isEmpty()) {
      $('.Signature-pad').addClass('Signature-pad-error');
      $('.description').addClass('Signature-error');
      return false;
    } else {
      $('#check_in_form_signature').val(signaturePad.toDataURL());
    }
  });
})
