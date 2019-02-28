<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<%-- 이거 없으면 안 뜸. 스타일 지정 해줘야 함. 필수. --%>
<style>
#map {   height: 100%;}
html, body {height: 100%;margin: 0;padding: 0;}
</style>

<%-- 키 값만 맞으면 거의 그냥 됨. 가끔 키 값 대신 sensor=true 아니면 sensor=false 해도 될 때도 있는데 잘 모르겠음.
async defer 는, 구글 맵 띄우는 동안 다른 화면들 동시에 작업하고 있으라고, 그런 기능 가능하게 해줌 --%>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>

<script>
<%-- 지도, 맵 객체는 본 스크립트 태그 안에서 여기저기서 쓸 거기 때문에 전역 변수로 선언.  --%>
var map;

<%-- 아까 선언해 놓은 map 객체에 google.maps 에서 제공하는 객체를 새로 받아다가 넣어 줌.
getElementById() 안에 있는 'map'은 아래에 div 태그의 id. 이름. 그 id를 가지는 div에 접근해서
받아온 map객체를 넣어 준다는 뜻.
center는 기본 좌표 위치 어디로 설정해 놓을지. 맵 딱 켜졌을 때 어디가 떠 있을지.
zoom은 맵 딱 켰을 때 크기 얼마나 확대해 놓을지. 기본 설정. --%>
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -34.397, lng: 150.644},
      zoom: 8
    });
  }
</script>

</head>
<body>
<%-- 바디 안에 어떤 구역이 최소한 하나는 있어야 위에 스크립트에서 작업한 맵을 화면 어딘가에 넣어주든 말든 하지 --%>
<div id="map"></div>
</body>
</html>