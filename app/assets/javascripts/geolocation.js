/* global $ */
function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(showPosition);
}

function showPosition(position) {
  console.log(position.coords);
  $.ajax({
    type: "POST",
    url: '/api/v1/geolocation.json',
    data: position.coords,
    dataType: 'json',
    success: function(response) {
      console.log(response);
    }
  });
}

getGeoLocation();