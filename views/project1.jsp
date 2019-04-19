<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap">
</script>

		<style>
			#map {
					width: 700px;
					height: 700px;
					position: relative !important; /*changing this to fixed makes the map dissapear*/
					top: 0; 
					bottom: 0; 
					left: 0; 
					right: 0; 
					z-index: 0;
	 		     }
			html,body {height: 100%; margin: 0; padding: 0;}
		</style>

		<script>
			var map;
			function initMap() {
			    map = new google.maps.Map(document.getElementById('map'), {
			      center: {lat: -34.397, lng: 150.644},
			      zoom: 8
			    });
			  }
		</script>
		
</head>
<body>
<div >
<div id = "map" ></div>
</div>
</body>
</html>