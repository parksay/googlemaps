<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<style>
#map {   height: 80%;}
html, body {height: 100%;margin: 0;padding: 0;}
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
var cood2; <%-- 그냥 내가 붙여 놓은 전역 변수, 검색 결과 좌표 담을 거임 --%>
var address;
function codeAddress1(tagid) {
	address = document.getElementById('origin').value;
    geocoder.geocode(
   		{ 'address': address }
   		, function(results, status) {
			if (status == 'OK') {
				map.setCenter(results[0].geometry.location);
				cood1 = results[0].geometry.location.toString();
				
				<%--=주석1= 이 부분은 할 말 있어서 밑에 주석 따로 달았음 --%>
				var output1 = document.getElementById('output1');
			    output1.innerHTML = String(cood1);
			    $('#'+tagid).val(cood1);

			    
				marker = new google.maps.Marker({ 
					map: map,
					position: results[0].geometry.location
			    });
   			} else {
   				alert('Geocode was not successful for the following reason: ' + status);
   			}
   		}
   );
    <%--=주석1= 이거 위에 if구문 안에 있는 거 지우고 여기에다가 쓰면 인식을 못하네?
    cood1에 값이 안 들어가네? 왜 그러지? java로 치면 돼야 하는 거 아닌가?
    java로 쳐도 안 되는 건가? 일단 위에 써놓고 함.
    var output1 = document.getElementById('output1');
    output1.innerHTML = String(cood1);
     --%>
 } 
 
function codeAddress2(tagid) {
	<%-- 중요한 게, 여기서 주소 값 받아오는 거 태그 id 잘 봐야 함. 계속 1번 박스에서 값 받아오고 있었음 ㅡㅡ --%>
    address = document.getElementById('destination').value;
    geocoder.geocode(
   		{ 'address': address }
   		, function(results, status) {
			if (status == 'OK') {
				map.setCenter(results[0].geometry.location);
				cood2 = results[0].geometry.location.toString();
				
				var output1 = document.getElementById('output1');
			    output1.innerHTML = String(cood2);
			    $('#'+tagid).val(cood2);

			    
				marker = new google.maps.Marker({ 
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

</head>
<body onload = "initMap()">
<div id="map"></div>
<div>
    <input id="origin" type="text" value="Sydney, NSW">
    <input type="button" value="출발지" onclick="codeAddress1('save1');">
</div>

<div>
    <input id="destination" type="text" value="Sydney, NSW">
   <input type="button" value="도착지" onclick="codeAddress2('save2');">
</div>

<div id = "output1">
</div>

<input type = "hidden" id = "save1" value = "hello">
<input type = "hidden" id = "save2" value = "hello">
</div>

</body>
</html>