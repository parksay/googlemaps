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
				<%-- 여기부터는 내가 추가 --%>

				var str1 = results[0].address_components[0].long_name;
				var output1 = document.getElementById('output1');
				output1.innerHTML = str1;
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

<title>Insert title here</title>
</head>
<body>
<div id="map" style="width: 100%; height: 90%;"></div>
<div>
    <input id="address" type="textbox" value="Sydney, NSW">
    <input type="button" value="Encode" onclick="codeAddress()">
</div>
<div id = "output1"></div>

<%-- 좌표 입력 => 그 좌표가 속해 있는 행정 구역 반환 => 그 행정 구역을 배열1의 값들 모두와 각각 비교
=> 같은 값이 있다면, 그 자리에 해당하는 배열2의 값을 cnt +1 하고, 다 비교해 봤는데 같은 값이 없다면 배열에 새로운 요소로 넣어 줌
=> 모든 좌표들에 대해 반복 => 배열2의 값들 중 가장 큰 값을 찾음 => 그 값의 자리값에 해당하는 배열1의 값을 찾음 =>
그 값으로 지도에 검색하든가, 그 값을 다시 좌표로 바꿔서 맵에 띄움 --%>
<script>

var arealist[] = null;
var areacnt[] = null;
if(arealist.length > 0 ) {
	var index_list = 0;
	for( i = 0; i <= coodlist.length; i = i + 1) {
		if( arealist[i].equals('search1') ) {
			index_list = i;
			areacnt[i] = areacnt[i] + 1; 
		}
		else {
			arealist.push('search1');
			areacnt.push(1);
		}
	}
	var max_cnt = 0;
	var index_cnt = 0;
	for(j = 0; j < areacnt.length; j = j + 1){
		if( max_cnt <= areacnt[j] ){
			max_cnt = areacnt[j];
			index_cnt = j;
		}
	}
	system.out.print(arealist[index_cnt]);
}
else{
	arealist.push('search1');
	areacnt.push(1);
}
</script>
</body>
</html>