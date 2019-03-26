
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#map { height: 80%;}
	html, body {height: 100%; margin: 0; padding: 0;}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>
<script type="text/javascript" src = "resources/js/jquery-3.3.1.min.js"></script>

<script>
var map;
var geocoder;
var marker;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -34.397, lng: 150.644},
      zoom: 8
    });
    geocoder = new google.maps.Geocoder();

 }

var cood1;
var cood2;
var address;

var saveco1;
var saveco2;
function codeAddress(tagid) {
	<%-- 패러미터에 따라서 출발지랑 도착지의 아이콘 다르게 하려고 일단 아이콘 만들어 놓음 --%>
	
	<%--출발지 마크 / 그냥 홈페이지에서 기본 마크로 설정해도 됨
	이건 경로 탐색이 별개로, 그냥 주소 찾기 기능의 이미지임.
	주소 찾으면 그 주소를 맵 중앙으로 옮기면서 마크 찍어줌.
	다만 이거를 그냥 주소 찾는 데에 내가 자체적으로 활용하는 거일 뿐.
	경로 탐색에서 출발지 도착지의 마크 정하는 코딩은 아래 경로탐색 함수에 따로 있음--%>
    var image1 = {
    	    url: 'resources/images/c049-2.png',
    	    // This marker is 20 pixels wide by 32 pixels high.
    	    size: new google.maps.Size(50, 50),
    	    // The origin for this image is (0, 0).
    	    origin: new google.maps.Point(0, 0),
    	    // The anchor for this image is the base of the flagpole at (0, 32).
    	    anchor: new google.maps.Point(0, 32)
    	  };
	<%--도착지 마크 / 그냥 홈페이지에서 기본 마크로 설정해도 됨 --%>

    var image2 = {
    	    url: 'resources/images/d088-2.png',
    	    // This marker is 20 pixels wide by 32 pixels high.
    	    size: new google.maps.Size(50, 50),
    	    // The origin for this image is (0, 0).
    	    origin: new google.maps.Point(0, 0),
    	    // The anchor for this image is the base of the flagpole at (0, 32).
    	    anchor: new google.maps.Point(0, 32)
    	  };
	
	<%-- 아까랑 다른 점은, 파라미터 받는 값에 따라서,
	주소 address 에다가 origin에 있는 값 넣어줄지, destination에 있는 값 넣어줄지 결정--%>
	if(tagid == 'save1')
		{ 	address = document.getElementById('origin').value; }
	if(tagid == 'save2')
	{ 	address = document.getElementById('destination').value; }
    geocoder.geocode(
   		{ 'address': address }
   		, function(results, status) {
			if (status == 'OK') {
				map.setCenter(results[0].geometry.location);
				<%-- 이 부분도 동적으로 바껴야 하네.
				출발지에서 주소 찾은 건지 도착지로 주소 찾은 건지에 따라 좌표 저장 다르게 --%>
				if(tagid == 'save1') {
					var output1 = document.getElementById('output1');
					saveco1 = results[0].geometry.location;
				    output1.innerHTML = saveco1.toString();
				    marker = new google.maps.Marker({ 
						map: map,
						position: results[0].geometry.location,
						icon: image1
				    });
				    
				}
				if(tagid == 'save2') {
					var output1 = document.getElementById('output1');
					saveco2 = results[0].geometry.location;
				    output1.innerHTML = saveco2.toString();
					marker = new google.maps.Marker({ 
						map: map,
						position: results[0].geometry.location, 
						icon: image2
				    });
				}
   			} else {
   				alert('Geocode was not successful for the following reason: ' + status);
   			}
   		}
   );

 } 
 
var service;
var markersArray = [];
var bounds;


function search(){
	bounds = new google.maps.LatLngBounds;
	geocoder = new google.maps.Geocoder;
	service = new google.maps.DistanceMatrixService;

	var origin1 = saveco1;
	var origin2 = $('#origin').val();
	var destinationA = $('#destination').val();
	var destinationB = saveco2;

	<%-- 출발지 도착지 마크 정하기--%>
	var destinationIcon = 'resources/images/c049-2.png';
	var originIcon = 'resources/images/d088-2.png';

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
				var outputDiv = document.getElementById('output2');
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

</head>
<body onload = "initMap()">
<div id="map"></div>
<div>
    <input id="origin" type="text" value="Sydney, NSW">
    <input type="button" value="출발지" onclick="codeAddress('save1');">
</div>

<div>
    <input id="destination" type="text" value="Sydney, NSW">
   <input type="button" value="도착지" onclick="codeAddress('save2');">
</div>

<div id = "output1">
</div>

<div>
<input type = "hidden" id = "save1" value = "hello">
<input type = "hidden" id = "save2" value = "hello">
</div>

<input type = "button"  value = "길찾기" onClick = "search();">
<div id = "output2">
</div>
</body>
</html>