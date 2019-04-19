<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#map {
		width: 750px;
		height: 500px;
		position: relative !important; /* changing this to fixed makes the map dissapear */
		top: 0; 
		bottom: 0; 
		left: 0; 
		right: 0; 
		z-index: 0;
     }
	html,body {height: 100%; margin: 0; padding: 0;}
</style>
</head>
<body>

	<div align="center">
		<div id="map"></div>
	</div>
	<input id="address" type="text" value="東京都中央区銀座２丁目" autocomplete="off">
	<input type="button" id="button_mapsearch" value="検索" onclick="codeAddress()">
	<input type="hidden" value="" id="lat">
	<input type="hidden" value="" id="lng">
	<input type="hidden" value="" id="region">

</body>

<!-- 맵 띄우기 위한 스크립트 -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap&language=ja&region=JP">
</script>
<script>
	var map;
	var geocoder;
	var marker;
	function initMap() {
/*

	
		이거는 만약에 객체로 보낼 때. 객체의 속성으로서 lat이나 lng나 region 값이 속해 있을 때.
		이렇게 할 경우에는 밑에 locations.region 이라든가 location.latitude 등으로 다 속성 값 써줘야 함
	 	var locations = [];
		<c:forEach items = "${requestScope.event_schedule_list}" var = "list">
			locations.push({ lat: ${list.latitude}, lng: ${list.longitude}, region: "${list.region}", name: "${list.name}", event_schedule_id: ${list.event_schedule_id}, content: "${list.content}", start_date: "${list.start_date}" });
		</c:forEach>
 */		
	var locations = ${requestScope.event_schedule_list};

 		console.log( JSON.stringify( locations ));
/*  		
 		locations 에 들어 있는 지역 이름들을 하나하나 꺼내서 중복을 없애기.
 		region_list 에는 지역 이름들이 중복 없이 들어 있음.
 		region_cnt 는 가장 자주 등장하는 지역 이름을 뽑기 위해, 등장하는 횟수를 세기 위한 배열
 		region_cnt 는 각 자리의 첨자 변수가 region_list 의 첨자 변수와 같음.
 		region_list 에서 중복해서 등장하는 지역 이름이 있다면 그 자리 값의 region_cnt를 +1 해줌.
  */		
		var region_cnt = [];
		var region_list = [];
		var i = 0;
		var j = 0;

/* 		
		중복을 제거하여 다른 배열에 다시 담아주는 구문. 기존의 배열에서 하나 뽑은 지역 이름이
		새로운 배열에 이미 있는 이름인지 확인해 보고 있으면 flag 세우고, 없으면
		새로운 배열에 새로 넣어주기
 */		
		var flag = false;
		for( i = 0; i < locations.length; i = i + 1 ){
			flag = false;
			for( j = 0; j < region_list.length; j = j + 1 ){
				console.log('for check j: ' + j + ' / i :' + i);
				if( region_list[j] == locations[i]　){
					region_cnt[j] = region_cnt[j] + 1;
					console.log('if check1: ' + region_list[j]);
					flag = true;
					break;
				}
			}
			if(!flag){
				region_list.push( locations[i] );
				region_cnt.push(1);
				console.log('if check2: ' + locations[i] );
			}
		}
		console.log( 'return check: region_list:' + JSON.stringify(region_list) );

/* 		
		region_cnt에 들어 있는 애들 중에, 가장 높은 숫자를 찾기.
		그 숫자의 자리 값이, 바로 가장 자주 등장하는 지역 이름의 자리 값
		그 자리 값을 index_region 에 넣어 놓기
 */		
		var max = 0;
		var index_region = 0;
		for( i = 0; i < region_cnt.length; i = i + 1){
			if( region_cnt[i] >= max ) {
				max = region_cnt[i];
				index_region = i;
			}
		}
		console.log( 'return check: ' + region_list[index_region] );

/* 		
		가장 자주 등장하는 지역 이름을 검색창에 기본 값으로 넣어주기.
		그리고 그 지역 이름으로 맵에 검색하여 중앙에 띄워주기 + 마커 찍어주기
 */		
		
		document.getElementById('address').value = region_list[index_region];
		geocoder = new google.maps.Geocoder();
		var address = region_list[index_region];
	    var latlng = new google.maps.LatLng(35.6766907, 139.77003390000004);
		geocoder.geocode(
			{ 'address': address }
		   		, function(results, status) {
					if (status == 'OK') {
						
						/* 해당 주소로 검색해서 좌표 값만 받아오는 중 */
						
						latlng = results[0].geometry.location;
					} else {
		   				alert('Geocode was not successful for the following reason: ' + status);
		   			}
		    });
		
		/* 아까 받아온 주소로 맵 중앙에 띄우는 중 */
	    var mapOptions = {
	    	      zoom: 15,
	    	      center: latlng
	    	    }
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
	    marker = new google.maps.Marker({ 
			map: map,
			position: latlng
		});
	}
	
	///////////////주소로 검색
	function codeAddress() {
	var result_area = "not_found";
    var address = document.getElementById('address').value;
	geocoder.geocode(
		{ 'address': address }
	   		, function(results, status) {
				if (status == 'OK') {
					map.setCenter(results[0].geometry.location);
					map.setZoom(15);
					/* 기존의 마커들 다 지우기 */
					marker.setMap(null);
					marker = new google.maps.Marker({ 
						map: map,
						position: results[0].geometry.location
				    });
					
					/* 
					검색해서 lat 값과 lng 값을 body 안에 hidden 태그로 보내 주기.
					가장 좁은 범위의 지역 이름 long_name  부터 찾아 보고 body 안에 hidden 태그로 보내주기
					 */
					 
					document.getElementById('lat').value = results[0].geometry.location.lat;
					document.getElementById('lng').value = results[0].geometry.location.lat;
					for( m = 0; m < results[0].address_components.length; m = m +1 ){ ////3번 시작
						if( results[0].address_components[m].types[0] == "sublocality" )
							{ 	
								result_area = results[0].address_components[m].long_name;
								document.getElementById('region').value = result_area;
								console.log('return check4: ' + result_area);								
								return;
							}
					}//3번 끝
					for( m = 0; m < results[0].address_components.length; m = m +1 ){ ////4번 시작
						if( results[0].address_components[m].types[0] == "administrative_area_level_3" )
							{ 	
								result_area = results[0].address_components[m].long_name;
								document.getElementById('region').value = result_area;
								console.log('return check3: ' + result_area);								
								return;
							}
					}//4번 끝
					for( m = 0; m < results[0].address_components.length; m = m +1 ){ ////5번 시작
						if( results[0].address_components[m].types[0] == "administrative_area_level_2" )
							{ 	
								result_area = results[0].address_components[m].long_name;
								document.getElementById('region').value = result_area;
								console.log('return check2: ' + result_area);								
								return;
							}
					}//5번 끝
					for( m = 0; m < results[0].address_components.length; m = m +1 ){ ////6번 시작
						if( results[0].address_components[m].types[0] == "administrative_area_level_1" )
							{ 	
								result_area = results[0].address_components[m].long_name;
								document.getElementById('region').value = result_area;
								console.log('return check1: ' + result_area);								
								return;
							}
					}//6번 끝
					for( m = 0; m < results[0].address_components.length; m = m +1 ){ ////6번 시작
						if( results[0].address_components[m].types[0] == "country" )
							{ 	
								result_area = results[0].address_components[m].long_name;
								document.getElementById('region').value = result_area;
								console.log('return check0: ' + result_area);								
								return;
							}
					}//6번 끝
					return result_area;
				} else {
	   				alert('Geocode was not successful for the following reason: ' + status);
	   			}
	   		}
	   );
	 } 
</script>

</html>