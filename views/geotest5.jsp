<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>
<script>
function initMap() {
	var bounds = new google.maps.LatLngBounds;
	var markersArray = [];
	
	<%--
	var lat1 = document.getElementById('x1');
	var lng1 = document.getElementById('y1');
	var lat2 = document.getElementById('x2');
	var lng2 = document.getElementById('y2');
	--%>
	var origin1 = {lat: 55.93, lng: -3.118};
	var origin2 = 'Greenwich, England';
	var destinationA = 'Stockholm, Sweden';
	var destinationB = {lat: 50.087, lng: 14.421};
	
	var destinationIcon = 'resources/images/c049-3.png';
	var originIcon = 'resources/images/d088-1.png';
	var map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: 55.53, lng: 9.4},
		zoom: 10
	});
	var geocoder = new google.maps.Geocoder;
	
	var service = new google.maps.DistanceMatrixService;
	service.getDistanceMatrix({
		origins: [origin1, origin2],
		destinations: [destinationA, destinationB],
		travelMode: 'DRIVING',
		unitSystem: google.maps.UnitSystem.METRIC,
		avoidHighways: false,
		avoidTolls: false
	}, function(response, status) {
			if (status !== 'OK') {
				alert('Error was: ' + status);
			} else {
				var originList = response.originAddresses;
				var destinationList = response.destinationAddresses;
				var outputDiv = document.getElementById('output');
				outputDiv.innerHTML = '';
				deleteMarkers(markersArray);
			    var showGeocodedAddressOnMap = function(asDestination) {
					var icon = asDestination ? destinationIcon : originIcon;
					return function(results, status) {
						if (status === 'OK') {
							map.fitBounds(bounds.extend(results[0].geometry.location));
							markersArray.push(new google.maps.Marker({
								map: map,
								position: results[0].geometry.location,
								icon: icon
							}));
						} else {
			   				alert('Geocode was not successful due to: ' + status);
			        	}
					};
				};
		
			for (var i = 0; i < originList.length; i++) {
		   		var results = response.rows[i].elements;
				geocoder.geocode({'address': originList[i]},
				showGeocodedAddressOnMap(false));
				for (var j = 0; j < results.length; j++) {
		 			geocoder.geocode({'address': destinationList[j]},
		  			showGeocodedAddressOnMap(true));
					outputDiv.innerHTML += originList[i] + ' to ' + destinationList[j] +
		      		': ' + results[j].distance.text + ' in ' +
		    		results[j].duration.text + '<br>';
				}
			}
		}
	});
}

function deleteMarkers(markersArray) {
	for (var i = 0; i < markersArray.length; i++) {
		markersArray[i].setMap(null);
	}
	markersArray = [];
}
</script>

<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
#map {
	height: 90%;
	width: 90%;
}
</style>
</head>
  
<body>
	<div id="map"></div>
	<div> x1: <input type = "text" id = "x1" value = "destination1 - x">
		y1: <input type = "text" id = "y1" value = "destination1 - y"></div>
	<div> x2: <input type = "text" id = "x2" value = "destination2 - x">
		y2: <input type = "text" id = "y2" value = "destination2 - y"></div>
	<div id="output"></div>
</body>
  
</html>