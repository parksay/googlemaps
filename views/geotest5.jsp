<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>
<script>

<%-- 전역변수로 넣어야 하는 것들, 이 함수에서 불러서 작업하고, 저 함수에서 그대로 받아서 이어서 작업할 요소들 --%>
var map;
var geocoder;
var service;
var markersArray = [];
var bounds;

<%-- 처음에 맵 띄우기. 기본형 --%>
function initMap() {
	
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -34.397, lng: 150.644},
        zoom: 8
      });
}

<%-- 경로를 검색하면 그 결과를 지도에 출력하기 전에, 기존의 검색 결과 마커를 지도로부터 지워주는 함수 --%>
function deleteMarkers(markersArray) {
	for (var i = 0; i < markersArray.length; i++) {
		markersArray[i].setMap(null);
	}
	markersArray = [];
}

<%-- 검색하는 함수 --%>
function search(){
	<%-- 원래 맵 만들면서 한 번만 정의하면 되는 객체들. 구글 맵스에서 지원하는 기능들을
	수행하기 위해, 그 기능을 담고 있는 객체들을 불러 옴. 자바로 치자면 멤버 메소드들 가지고 있는
	클래스들을 임포트해서 인스턴스 하나 만드는 것과 비슷 --%>
	bounds = new google.maps.LatLngBounds;
	geocoder = new google.maps.Geocoder;
	service = new google.maps.DistanceMatrixService;

	<%-- 그냥 암 것도 아님. 입력해 놓은 x좌표와 y좌표를 불러 옴. 도착지와 출발지 각각의 x좌표와 y좌표임.
	지금은 직접 입력했지만 나중에는 사용자가 검색하면, 그 검색 결과로부터 lat과 lng 분리해서 받아올 예정
	LatLng 객체라면 그대로 꽂아줘도 됨. 검색 결과로 나오는 LatLng 객체를 굳이 string으로 변환해서
	' , ' 기준으로 lat과 lng를 나누고, 둘을 다시 Number('~~') 함수 이용해서 숫자로 바꿔서,
	다시 넣어주는 건 일 만들어서 하는 격. 이거는 내가 시험해보느라 x좌표 y좌표 직접 입력해서 받아 온 것 뿐임--%>
	var lat1 = document.getElementById('x1');
	var lng1 = document.getElementById('y1');
	var lat2 = document.getElementById('x2');
	var lng2 = document.getElementById('y2');

	<%-- 도착지와 출발지에 대한 정보. origin은 출발지, destination은 도착지
	origin1은 출발지의 좌표 객체, origin2는 출발지의 주소 문자열
	destinationA는 도착지의 주소 문자열, destinationB는 도착지의 좌표 객체 --%>
	var origin1 = new google.maps.LatLng(lat1.value, lng1.value);
	var origin2 = 'Greenwich, England';
	var destinationA = 'Stockholm, Sweden';
	var destinationB = new google.maps.LatLng(lat2.value, lng2.value);

	<%-- 그냥 아이콘. 강아지 고양이는 그냥 작업하는 동안 귀여운 거 보고싶어서 해놓은 거임.
	구글에서 기본 제공해주는 마커 사용하는 게 제일 깔끔. 바꾸는 건 쉬움. 걍 사이트 가서 코드 복붙 --%>
	var destinationIcon = 'resources/images/c049-2.png';
	var originIcon = 'resources/images/d088-2.png';

	<%-- 구글에서 제공해주는 service 객체를 불러 와서 변수에 넣어 줌. service 에 속해 있는 멤버 메소드
	getDistanceMatrix 를 실행해달라고 함. 패러미터로 객체 하나 보내줌. 그 패러미터 안에 
	origins랑 destinations랑(아까 위에서 만든 거) 교통수단이랑 기타 선호 옵션 들 넣어 줌 --%>
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
	<div> x1: <input type = "text" id = "x1" value = "55.1652">
		y1: <input type = "text" id = "y1" value = "53.5516"></div>
	<div> x2: <input type = "text" id = "x2" value = "55.3512">
		y2: <input type = "text" id = "y2" value = "53.5153"></div>
	<div><input type = "button" value = "검색" onClick = "search()"></div>
	<div id="output"></div>
	<div id = "test">
	
	</div>
</body>
  
</html>