// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks

function initialize(geocoder){
 	if (navigator.geolocation) {
    console.log('Geolocation is supported!');
    var pos;
    function successCallback(position){
      pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      }
      var latLng = new google.maps.LatLng(pos.lat, pos.lng);
      geocoder.geocode({
    	latLng: latLng
  		}, function(responses) {
    	if (responses && responses.length > 0) {
      		$("#form-address").val(responses[0].formatted_address)
    	} });
    }
	function errorCallback(error){}

    navigator.geolocation.getCurrentPosition(successCallback, errorCallback,{maximumAge:600000});
	}
 } 