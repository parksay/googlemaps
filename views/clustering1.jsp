<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap""></script>
<script>

function initMap() {

	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 3,
		center: {lat: -28.024, lng: 140.887}
	});
	
	<%-- 마커에서 하나씩 꺼내서 쓸 라벨들 미리 지정 --%>
	var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	<%-- 밑에서 입력해 놓은 locations 라는 array를 바탕으로 maker들을 만듦.
	단, 이 함수에서 쓰인 map() 메소드는 google map이랑 노상관.
	javascript에서 지원하는 메소드임. 자바에서 hashMap() 같은 거임
	a.map(f(x, y) ) 이러면 a의 요소 하나하나를 꺼내서 f()를 실행함
	그리고 f()의 파라미터  x랑 y 설명하자면, a에서 하나하나 꺼내와서
	각각에 대해 f()를 실행해 줄 때 그 현재 a에서 꺼내온 요소가 x. 객체든 숫자든 뭐든.
	y는 그 요소가 a에서 몇 번째에 있는 앤지. x는 필수 파라미터, y는 선택 파라미터--%>

		var markers = locations.map(function(location, i) {
			<%-- 이 부분은 그냥 없어도 됨. 그냥 밑에서 clustering 이미지랑 겹치면 바뀌는 거 안 보일
			것 같아서, 첨자 변수에 3 더해서 보여주는 거 뿐 --%>
			var x = i + 3;
			return new google.maps.Marker({
					<%-- 기본 샘플에는 이 아이콘 부분이 없음. 내가 추가한 거임.
					나중에 실제로 돌릴 때는 position 에 넣을 좌표도
					사진으로부터 직접 받아오는 코딩 넣어야 함.
					{ ~~~ } 해가지고 즉석에서 받아오는 코딩을 반복문 형태로 돌릴 수 있게끔--%> 
				position: location,
				label: labels[i % labels.length],
				icon: {
		     	    url: 'resources/images/clustering/samplepng/sampleimg' + x + '.png',
		     	    <%-- 사이즈 정하는 거 여기 있네? 일일이 크기랑 확장자 변환 안 바꿔도 되나? --%>
		     	    size: new google.maps.Size(50, 50),
		     	    origin: new google.maps.Point(0, 0),
		     	    anchor: new google.maps.Point(0, 32)
				} 
			});
		});
<%--
     var image = {
     	    url: 'resources/images/c049-2.png',
     	    size: new google.maps.Size(50, 50),
     	    origin: new google.maps.Point(0, 0),
     	    anchor: new google.maps.Point(0, 32)
     	  };
     
     var beachMarker = new google.maps.Marker({
         position: {lat: -33.91721, lng: 151.22631},
         map: map,
         icon: image
       });
	 --%>
	 
	 
	 
	 
        <%-- 마커 클러스터 생성함. 맵 객체 변수 이름, 그 안에 넣을 마커들, 마커 클러스터의 이미지
        여기서 주의할 게, 뒤에 경로 설정할 때 뒤에 풀로 갖다가 붙여주는 게 아님. 중간에 생략 됨.
        맵 확대 스케일에 따라서 지들이 알아서 그 크기에 맞는 이미지를 가져옴. 그니까 뒤에
        1.png / 2.png / 3.png / 등을 자동으로 붙여 줌. 그 맵 확대 크기에 따라서. 그러니까 뒤에
        맞춰줘야 함. 그냥 뭐, 기본으로 받아다가 써도 되고.
        기본 경로는 이거임
        'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
         --%>
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'http://localhost:8888/googlemaps/resources/images/clustering/samplepng/sampleimg'});
		}
		
	var locations = [
		{lat: -31.563910, lng: 147.154312},
		{lat: -33.718234, lng: 150.363181},
		{lat: -33.727111, lng: 150.371124},
		{lat: -33.848588, lng: 151.209834},
		{lat: -33.851702, lng: 151.216968},
		{lat: -34.671264, lng: 150.863657},
		{lat: -35.304724, lng: 148.662905},
		{lat: -36.817685, lng: 175.699196},
		{lat: -36.828611, lng: 175.790222},
		{lat: -37.750000, lng: 145.116667},
		{lat: -37.759859, lng: 145.128708},
		{lat: -37.765015, lng: 145.133858},
		{lat: -37.770104, lng: 145.143299},
		{lat: -37.773700, lng: 145.145187},
		{lat: -37.774785, lng: 145.137978},
		{lat: -37.819616, lng: 144.968119},
		{lat: -38.330766, lng: 144.695692},
		{lat: -39.927193, lng: 175.053218},
		{lat: -41.330162, lng: 174.865694},
		{lat: -42.734358, lng: 147.439506},
		{lat: -42.734358, lng: 147.501315},
		{lat: -42.735258, lng: 147.438000},
		{lat: -43.999792, lng: 170.463352}
	]
</script>
<title>Marker Clustering</title>
<style>
	#map {
		height: 90%;
	}
	html, body {
		height: 100%;
		margin: 0;
		padding: 0;
	}
</style>
</head>
<body>

<div id="map"></div>

</body>
</html>