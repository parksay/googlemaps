<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id = "map"></div>
</body>


<!-- 東京　京橋駅 : { 35.6766907 , 139.77003390000004 } -->
<script>
function initMap() {
    var latlng = new google.maps.LatLng(35.6715003, 139.764913);
    var mapOptions = {
    	      zoom: 15,
    	      center: latlng
    	}
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
	var geocoder = new google.maps.Geocoder();
	
 	   /* /////////////여기부터 다음 */
	/* 	console.log( JSON.Stringify(${requestScope.event_schedule_list[0].latitude}) ); 
		
 	[{"lat":35.6693907,"lng":139.76803390000003,"region":"東京"},
 		{"lat":35.66676907,"lng":139.757390000004,"region":"東京"},
 		{"lat":35.6685256,"lng":139.7679124,"region":"東京"},
 		{"lat":35.67016907,"lng":76203390000004,"region":"東京"},
 		{"lat":35.67002907,"lng":139.7685339000003,"region":"東京"},
 		{"lat":35.67106907,"lng":139.762133900004,"region":"東京"},
 		{"lat":35.6759907,"lng":139.7707339000004,"region":"東京"},
 		{"lat":35.6766907,"lng":77013380004,"region":"東京"},
 		{"lat":67556907,"lng":139.7699033257,"region":"東京"},
 		{"lat":35.67606907,"lng":139.77113941000005,"region":"東京"},
 		{"lat":35.67506907,"lng":139.77044100004,"region":"東京"},
 		{"lat":35.67526907,"lng":139.76835000004,"region":"東京"},
 		{"lat":35.6681907,"lng":139.7601033333004,"region":"東京"},
 		{"lat":35.66726907,"lng":139.7598539004,"region":"東京"},
 		{"lat":35.66956907,"lng":139.76103390000003,"region":"東京"},
 		{"lat":35.6691329,"lng":139.7693181,"region":"東京"}]
 	
		*/
 	
 	/* 
 		서버에서 model(request)로 보내준 event_schedule_list라는 이름의 
 		ArrayList 객체를 하나하나 꺼내서 자바 스크립트 배열에 넣어주기
 	*/
	 	var locations = [];
		<c:forEach items = "${requestScope.event_schedule_list}" var = "list">
			locations.push( {lat: ${list.latitude}, lng: ${list.longitude}, region: "${list.region}"} );
		</c:forEach>
	 		
 		console.log( locations[0].lat ); 

		var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		
		/* 좌표 각각들에 대해 마커 객체를 생성해서 맵에 띄우는 함수  */
		var markers = locations.map( function(location, i) {
			return new google.maps.Marker({	
					position: new google.maps.LatLng(locations[i].lat, locations[i].lng),
					label: locations[i].name
				});
			});		
		
		
		/* 마커 배열로 클러스터 찍어주는 함수  */
       var markerCluster = new MarkerClusterer(map, markers,
           {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
       
		/* 마커 배열에 있는 마커 객체들 하나하나 꺼내서 클릭 이벤트 걸어주는 함수 */     
		markers.map( function(marker, i) {
			
			var infowindow = new google.maps.InfoWindow({
		          content:  '<img src = "resources/images/clustering/samplepng/sampleimg' + i + '.png">',
		          maxWidth: 250
		        });
			  marker.addListener('click', function() {
					infowindow.open(map, marker);
				});
			});
       
       /* 마커 클릭했을 때 위에 툴팁 띄워주는 함수 
       var infowindow = new google.maps.InfoWindow({
	          content: 'test',
	          maxWidth: 200
	        });
       
     	 마커에 클릭 이벤트 걸어주는 함수      
       marker.addListener('click', function() {
           infowindow.open(map, marker);
         }); */
       
}
</script>
</html>