<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>

<script>
<%-- 전역 변수로 geocoder 선언. 구글에서 제공하는 geocoder 객체에 접근해서 불러다가 여기다 넣을 거임 --%> 
var geocoder;
var map;

function initMap() {
	<%-- google.maps에서 제공하는 Geocoder 객체 불러다가 geocoder에 넣어 줌 --%>
    geocoder = new google.maps.Geocoder();
    
    <%-- 기본 맵 생성이랑 똑같은데, map 객체 생성할 때 함께 지정해줘야 하는 옵션들을, 
    mapOptions 라는 객체에 담아서 알려준 것 뿐. 원래 맵 띄울 거면, center는 어디인지,
    zoom은 어느 정도 당길지, 함께 알려줘야 띄울 수 있음. 그거를 map 정의할 때 즉석에서 
 	선언해줘도 좋고(이게 기본맵 생성 코딩에 있는 방식) 따로 객체에 담아서 알려줘도 좋고(이게 본 코딩) --%> 
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    <%-- 위에 거는 센터 어딘지 좌표 지정해주는 변수. 아래는 map 정의할 때 필요한 속성들 담는 객체 --%>
    var mapOptions = {
      zoom: 8,
      center: latlng
    }
    map = new google.maps.Map(document.getElementById('map'), mapOptions);
  }
  
<%-- 밑에 바디에 있는 input-text 태그에다가 검색어 입력하고 나서 버튼 클릭하면
onclick 해놔서 아래 함수 실행. 검색어 value 받아다가 와서 결과 출력해줌.
결과는 results[]에 배열로 담아서 보내줌. 가장 근사한 결과값부터 관련성이 떨어지는 결과값까지 차례대로
0부터 순서대로 담아줌. 
그럼 그 결과값으로부터 좌표 받아다가  map.setCenter 메소드에 패러미터로 넣어주면서
화면에 떠 있는 지도의 위치를 바꿔 줌.--%>   
function codeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode(
   		{ 'address': address }
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