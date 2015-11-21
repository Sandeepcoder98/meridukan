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
      		address= ""
          for(i=0;i<4;i++)
          {address= address + responses[0].address_components[i]["long_name"]+" "  }
          //responses[0].address_components[0]["long_name"]+","+responses[0].address_components[1]["long_name"]+","+responses[0].address_components[2]["long_name"]+","+responses[0].address_components[3]["long_name"]+","+responses[0].address_components[4]["long_name"]
          $("#form-address").val(address)
    	} });
    }
	function errorCallback(error){}

    navigator.geolocation.getCurrentPosition(successCallback, errorCallback,{maximumAge:600000});
	}
 } 