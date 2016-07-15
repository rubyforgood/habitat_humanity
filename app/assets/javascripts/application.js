// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require lolliclock
//= require signature
//= require turbolinks
//= require_tree .

(function ($) {
  var ready, eventsToBind;

  ready = function () {
    var $input, picker;

    // Initialize all datepickers
    $('.datepicker').pickadate({
        selectMonths: true,
        selectYears: 15,
        autoclose: true
    });

    // Initialize the datepicker on the sign-in form
    $input = $('#sign_in_form_day').pickadate();
    picker = $input.pickadate('picker');
    picker.set('select', new Date());

    // Initialize time picker
    $('#pick-a-time').lolliclock({ autoclose:true });

    $('#pick-a-time').click(function() {
      $('#pick-a-time').blur();
      // e.preventDefault();
    });
  };

  // Fix for turbolinks + jquery bugs
  eventsToBind = ['ready', 'page:load', 'page:update'];
  eventsToBind.forEach(function (event) {
    $(document).on(event, ready);
  });
}($));
