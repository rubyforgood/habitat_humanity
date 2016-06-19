//= require signature_pad
$( document ).ready(function() {
  $('select').material_select();
  $( ".dropdown-content span:contains('Break')" ).append( " <sup class='Signature-sup'>* signature not required</sup>" );
  $( ".dropdown-content span:contains('Break')" ).closest('li').addClass('break')
  $(".select-dropdown li").on('click', function(e) {
    $span = $(e.target)
    if($span.closest('li').hasClass('break')){
      $('.Signature-visable').css('display', 'none')
      $('.signature-field').val('N/A')
    } else {
      $('.Signature-visable').css('display', 'block')
      $('.signature-field').val('')
    }
  })


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
    if ($('.signature-field').val('')) {
      $('.Signature-pad').addClass('Signature-pad-error');
      $('.description').addClass('Signature-error');
      return false;
    } else {
      $('#check_in_form_signature').val(signaturePad.toDataURL());
    }
  });
})
