// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require gmaps-auto-complete
//= require turbolinks
//= require bootstrap
//= require leaflet
//= require leaflet-google
//= require certifications
//= require requirements
//= require user_steps
//= require tagmanager
//= require jquery.tokeninput
//= require moment
//= require bootstrap-datetimepicker

//= require_tree .
//= require leaflet-google
//= require leaflet


jQuery(function() {
   $('#user_certificate_list').tokenInput('./tags.json', {
    propertyToSearch: 'title'
  });
});

function populate_second_select(currentId){
  var e = document.getElementById(currentId);
  var selectedText = e.options[e.selectedIndex].text;
  $.ajax({
     method:'GET',
     url:'./state_response',
     data: {value:selectedText}
   });
}
