  function initializeGmap() {
    var geocoder = new google.maps.Geocoder();
    google.maps.event.addDomListener(document, 'ready', initialize(geocoder)); 
  }