<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>

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
  
<%-- 좌표를 저장할 전역 변수 선언 --%>
var coord;
  
function codeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode(
   		{ 'address': address }
   		, function(results, status) {
			if (status == 'OK') {

				<%-- 아까 선언한 변수에 좌표를 넣어줌. results는 검색한 결과가 되는 객체 들어있는 배열이고,
				끝에 [0]은 그 중에 가장 근사 결과를 나타냄. 0번이 가장 일치하는 결과, 숫자 클수록 관련성 적은 결과.
				results[0]에 담긴 geomtry 속성 중에서 location 속성을 꺼내면, 자료형이 LatLng 임.
				https://developers.google.com/maps/documentation/javascript/geocoding?hl=ko
				에서 results 참조.
				그럼 LatLng라는 자료형의 여러 멤버메소드 중에서 toString()을 실행하면 return값이 문자열.
				https://developers.google.com/maps/documentation/javascript/reference/coordinates?hl=ko
				에서 Coordinates 참조.
				이러한 결과로 해서, String 값을 아까 선언한 전역 변수에 담아 줌. --%>
				coord = results[0].geometry.location.toString();
				<%-- 다음 줄은 String으로 넣어 놓은 좌표를 div에 띄우는 함수. 아래에 선언해 놓음 --%>
				outputCoord(coord);
				
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
  
   <%-- String으로 변환된 좌표를 body에 있는 div에 띄워주는 함수 --%>
function outputCoord(co){
	<%-- 나누지 않고 x좌표 y좌표 묶어서 그대로 출력 --%>
	var divcood = document.getElementById('coord');
	divcood.innerHTML = '좌표:' + co;
	
	
	<%-- x좌표와 y좌표로 나누어서 따로 출력 --%>
	<%-- document 이용해서 div 에 접근 --%>
	var divlat = document.getElementById('lat');
	var divlng = document.getElementById('lng');

	<%-- ' , '를 기준으로 String(좌표)을 나눔 --%> 
	var latlngStr = co.split(',', 2);
	var Strlat = latlngStr[0];
	var Strlng = latlngStr[1];
	
	<%-- 아까 접근해 놓았던 div에 넣어 줌 --%>
	divlat.innerHTML = 'x좌표:' + Strlat;
	divlng.innerHTML = 'y좌표:' + Strlng;	
		
	<%-- 이거는 String을 숫자 자료로 바꾸는 기능.
	parseFloat을 이용해서 x좌표와 y좌표를 각각 Float자료로 변환한 후에 저장 --%>
	var latlngStr = co.split(',', 2);
	var Floatlat = parseFloat(latlngStr[0]);
	var Floatlng = parseFloat(latlngStr[1]);
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
<div id = "coord"> </div><br>
<div id = "lat"> </div><br>
<div id = "lng"> </div>

</body>
</html>