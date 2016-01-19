function initialize(geocoder) {
  if (navigator.geolocation) {
    console.log('Geolocation is supported!');
    var pos;
    function successCallback(position){
      pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      }
      var latLng = new google.maps.LatLng(pos.lat, pos.lng);
      updateMarkerPosition(latLng);
      geocodePosition(geocoder,latLng);
      map.setZoom(14);
      marker.setPosition(latLng);
      map.setCenter(latLng)      
    }

    function errorCallback(error){}

    navigator.geolocation.getCurrentPosition(successCallback, errorCallback,{maximumAge:600000});
  }

  if (pos==undefined) {
    var latLng = new google.maps.LatLng(22.6954909, 75.87088089999997);
  }
  else{
    var latLng = new google.maps.LatLng(pos.lat, pos.lng);
  }   
  
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 14,
    center: latLng,
    scrollwheel: true,
    streetViewControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var marker = new google.maps.Marker({
    position: latLng,
    title: 'Point A',
    map: map,
    draggable: true
  });

  var pinColor = "2F76EE";
  var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
            new google.maps.Size(21, 34),
            new google.maps.Point(0,0),
            new google.maps.Point(10, 34));

 // Update current position info.
  updateMarkerPosition(latLng);
  document.getElementById('location').innerHTML ="Drag marker to your location or share your location"

  map.panTo(marker.getPosition());
  // Add dragging event listeners.
  google.maps.event.addListener(marker, 'dragstart', function() {
    updateMarkerAddress('Dragging...');
  });
  
  google.maps.event.addListener(marker, 'drag', function() {
     updateMarkerPosition(marker.getPosition());
  });
  
  google.maps.event.addListener(marker, 'dragend', function() {
    geocodePosition(geocoder,marker.getPosition());
  });
}

function updateMarkerPosition(latLng) {
  // document.getElementById('location').innerHTML = [ 
  // latLng.lat(),latLng.lng()].join(", ")
}

function updateMarkerAddress(str) {
  //document.getElementById('address').value = str;
  document.getElementById('street-address').value= str;
}

function geocodePosition(geocoder,pos) {
  geocoder.geocode({
    latLng: pos
  }, function(responses) {
    if (responses && responses.length > 0) {
     address = parseAddress(responses)
     updateMarkerAddress(address);
    } else {
      updateMarkerAddress('Cannot determine address at this location.');
    }
  });
}

function parseAddress(responses) {
  address=""
  for(i=0;i<4;i++)
  {address= address + responses[0].address_components[i]["long_name"]+" "  }
  return address
}
