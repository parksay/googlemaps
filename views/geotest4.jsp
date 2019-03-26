<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap&language=KO&region=KR""></script>

<script>
var geocoder;
var map;

function initMap() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    var mapOptions = {
      zoom: 8,
      center: latlng
    }
    map = new google.maps.Map(document.getElementById('map'), mapOptions);
  }
  
function codeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode({
    	'address': address
    	<%-- 이건 아주 엄격하게 그 국가 안에서만 검색하는 듯. KR 즉 한국이 아니면
    	그외 결과는 없는 셈 침. 애초에 가져오질 않음 
    		--%>
   		, componentRestrictions: {
    		country: 'KR'
   		}
   	
   	}
  	, function(results, status) {
		if (status == 'OK') {
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({ 
				map: map,
				position: results[0].geometry.location
		    });
  			} else {
  				alert('Geocode was not successful for the following reason: ' + status);
  			}
  		}
	);
} 
  
  
</script>

<style>
#map {   height: 100%;}
html, body {height: 100%;margin: 0;padding: 0;}
</style>

</head>

<body>


<div id="map" style="width: 100%; height: 90%;"></div>

<div>
    <input id="address" type="textbox" value="Sydney, NSW">
    <input type="button" value="Encode" onclick="codeAddress()">
    
</div>
</body>
</html>