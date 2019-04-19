<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>
<style>
#map {   height: 100%;}
html, body {height: 100%;margin: 0;padding: 0;}
</style>

<script>
var map;
var geocoder;
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
	<%-- 맵 필수 변수 말고, 내가 쓸려고 만든 변수들 --%>
	var arealist = []; <%-- 맵스에 좌표 보내주면 지역 이름 넘겨줄 건데, 그 지역 이름들을 모아서 넣어둘 배열--%>
	var areacnt = []; <%-- 그 지역 이름이 몇 번 나왔나 빈도수를 저장할 배열 (list와 배열 첨자가 같아야 함,주의) --%>
	var index_list = 0; <%-- 지역 이름 목록의 첨자 변수--%>
	var index_cnt = 0; <%-- 지역 이름들의 빈도수를 저장한 배열의 첨자 변수 --%>
	var max_cnt = 0; <%-- 빈도수 중에 가장 자주 나온 지역 이름의 위치를 기억할 첨자 변수--%>
	var output = document.getElementById('output');  <%-- 출력해줄 div의 객체 접근 변수--%>
	var output1 = document.getElementById('output1'); <%-- 그냥 연습용 출력 div--%>
	var flag = false; <%-- 맵스가 반환해준 지역 이름이, 이미 목록에 있는지 여부를 확인하는 flag --%>
	var str1 = "HelloBigWorld!"; <%-- 맵스에게 좌표를 보내주면 지역 이름을 반환해주는데, 그 지역 이름을 임시로 저장할 string--%>
	var totalflag = false; <%-- for구문 전체가 다 돌았는지 확인할 flag
				(이거는 javascript가 쓰레드 방식으로 작동해서, for구문이 다 끝날 때까지 기다렸다 실행해야 함.
				그래서 flag 세워놓고 setinterval로 계속 반복해서 확인 함. flag 세워질 때까지--%>
    var address = document.getElementById('address').value; <%-- 사용자가 검색하기 위해 입력해 놓은 검색어를 받아오기 위한 객체 접근 변수--%>
    var smallflag = false; <%-- 맵스가 반환해주는 요소 중에 administrative_area_level_2 요소가 있는지 여부를 확인할 flag--%>
    
    <%-- 좌표 목록. 무료 키는 5개 밖에 안됨--%>
	var coodlist = [
		{lat: -41.330162, lng: 174.865694},
		{lat: -42.734358, lng: 147.439506},
		{lat: -42.734358, lng: 147.501315},
		{lat: -42.734358, lng: 147.501315},
		{lat: -43.999792, lng: 170.463352}
	
	];
    
	arealist[0] = str1;
	areacnt[0] = 0;
	for( i = 0; i < coodlist.length; i = i + 1) {
		
		geocoder.geocode({'location': coodlist[i]}
	   		, function(results, status) {
	   			
				if (status == 'OK') {
					console.log('1 - ' + i + coodlist[i]);
						flag = false;
					smallflag = false;
					for( m = 0; m < results[0].address_components.length; m = m +1 ){
						if( results[0].address_components[m].types[0] == "administrative_area_level_2" )
							{ 	str1 = String( results[0].address_components[m].long_name );
								smallflag = true;
								break; }
							}
						output1.innerHTML = arealist[0];
						if(smallflag){
							for( j = 0; j <= arealist.length; j = j + 1 ){
								if( str1 == arealist[j] ) {
									index_list = j;
									areacnt[j] = areacnt[j] + 1;
									flag = true;
									break;
								}
							}
							if(!flag){
								arealist.push(str1);
								areacnt.push(1);
							}
						}
	   			} else {
	   				alert('Geocode was not successful for the following reason: ' + status);
	   			}
	   		}
	   );
		totalflag = true;
	}
	var interval = setInterval(function()
			{
				if(totalflag)
				{
					for(k = 0; k < areacnt.length; k = k + 1){
						if( max_cnt <= areacnt[k] ){
							max_cnt = areacnt[k];
							index_cnt = k;
						}
					}
					output.innerHTML = arealist[index_cnt];
					clearInterval(interval);
				}
			}, 100);
 }
 
</script></head>
<body>
<div id="map" style="width: 100%; height: 90%;"></div>
<div>
    <input id="address" type="textbox" value="Sydney, NSW">
    <input type="button" value="Encode" onclick="codeAddress()">
</div>
<div id = "output1"></div>
<div id = "output"></div>
Uncaught TypeError: Cannot set property 'innerHTML' of null 
이거는 니가 지금 넣으려는 div가 없대. 어따 넣을 건데, 그게 없대.
</body>
</html>