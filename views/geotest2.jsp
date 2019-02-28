<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>
<style>
html, body {height: 100%;margin: 0;padding: 0;}
</style>
<script>
<%-- 그냥 맵 소환하는 스크립트 부분. 기본 맵이랑 다른 점은,
구글 맵으로부터 geocoder랑 infowindow 받아오는 코딩이 추가된 것뿐 --%> 
function initMap() {
	  var map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 8,
	    center: {lat: 40.731, lng: -73.997}
	  });
	  var geocoder = new google.maps.Geocoder;
	  var infowindow = new google.maps.InfoWindow;

<%-- 'click'이라는 event를 listen해주는 기능을 추가. click이라는 event가 일어났을 때
실행할 함수의 이름이 geocodeLatLng()이고, 그 parameter로는 아까 받아 놓았던 구글의 객체인
geocoder랑 map이랑 infowindow 객체 보내주는 것. 어떤 맵에 띄울지? 아까 시작할 때 소환했던 맵에서
좌표 표시해달라고. 그  객체 패러미터로 보내주는 거 --%>
	  document.getElementById('submit').addEventListener('click', function() {
		  	geocodeLatLng(geocoder, map, infowindow);
	  });
}


<%-- submit이라는 id를 가진 객체를 클릭하면 실행될 함수.
세부 기능을 살펴보자면, 사용자가 latlng라는 id를 가진 태그에 입력해놓은 value를 받아 옴.
받아다가 input에 넣어 줌. 그리고 그 input을 string으로 바꾸고 나서 ' , ' 쉼표를 기준으로 앞뒤로 나눔.
앞은 latitude로, 뒤는 longitute로 넣어 줌. 나눈 걸 한번에 latlng라는 변수에 넣어 줌.
그 좌표를 맵 중앙으로 띄움. --%>
function geocodeLatLng(geocoder, map, infowindow) {

	var input = document.getElementById('latlng').value;
	var latlngStr = input.split(',', 2);
	var latlng = { lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1]) };
	geocoder.geocode({'location': latlng}, function(results, status) {
		if (status === 'OK') {
			if (results[0]) {
				map.setZoom(11);
				var marker = new google.maps.Marker({
					position: latlng,
					map: map
				});
				infowindow.setContent(results[0].formatted_address);
				infowindow.open(map, marker);
			} else {
				window.alert('No results found');
			}
		} else {
			window.alert('Geocoder failed due to: ' + status);
		}
	});
}


</script>

</head>
<body>

<%-- px이 아니라 %로 할 거면 도대체 무엇의 몇%를 말하는 건지 알아야지.
90%면, 그래서 뭐의 90%냐고. 그래서 내가 움직일 수 있는 범위가 어딘지 지정을 우선 해 줘야 함.
그게 바로 위에 style에서 margin이랑 height랑 지정해주는 거. px로 할 거면 style 부분 생략 가능 --%>
<div id="map" style="width: 100%; height: 90%;"></div>

<div>
	<input id="latlng" type="textbox" value="input latlng">
	<input type="button" value="search" id = "submit">
</div>
</body>
</html>