<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

 <style>
      #map {
        height: 100%;
      }
      html, body {height: 100%; margin: 0; padding: 0;}
    </style>
  </head>
  <body>
<span class="metadata-marker" style="display: none;" data-region_tag="html-body"></span>    <div id="map"></div>
    <script>
    <%--이건 그냥 기본적으로 맵 띄우는 코딩. 똑같음 --%>
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 16,
          center: new google.maps.LatLng(-33.91722, 151.23064),
          mapTypeId: 'roadmap'
        });

        var iconBase = 'resources/images/c049-3.png';
        
        <%-- url 속성은 이미지 파일 불러 오기.
        size 속성은 크기. pixel 단위
        origin이랑 anchor는 모르겠음. 없어도 되긴 함 --%>
        var image = {
        	    url: 'resources/images/c049-2.png',
        	    // This marker is 20 pixels wide by 32 pixels high.
        	    size: new google.maps.Size(50, 50),
        	    // The origin for this image is (0, 0).
        	    origin: new google.maps.Point(0, 0),
        	    // The anchor for this image is the base of the flagpole at (0, 32).
        	    anchor: new google.maps.Point(0, 32)
        	  };
		<%-- 하나의 위치에 마커 띄울 때. position 에 좌표, map은 map객체 이름? 잘 몰라
		icon은 아까 생성했던 image 객체 --%>
        var beachMarker = new google.maps.Marker({
            position: {lat: -33.91721, lng: 151.22631},
            map: map,
            icon: image
          });
        
        
        <%-- 이거는 여러 위치에 마커 띄울 때. 어떻게 할 거냐면,
        	일단 위치만 여러 개 한 번에 저장 다 해놔. 위치 정보만 몰아서 등록해 놓음. 그러고 나서,
        	나중에 for문 돌리면서 그 위치만 불러다가 마커 생성하는 것만 한번에 몰아서 해줌
        	position은 좌표, type 은 어떤 이미지 띄울지. 카페면 카페에 맞는 이미지,
        	도서관이면 도서관에 맞는 이미지, 등등. 본 코딩에서는 모든 type에 대해 하나의 이미지만
        	등록해 놨는데, 밑에서 각 type마다 다른 이미지 넣는 코딩도 게시하겠음. --%> 
        var features = [
          {
            position: new google.maps.LatLng(-33.91721, 151.22630),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91539, 151.22820),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91747, 151.22912),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91910, 151.22907),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91725, 151.23011),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91872, 151.23089),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91784, 151.23094),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91682, 151.23149),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91790, 151.23463),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91666, 151.23468),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.916988, 151.233640),
            type: 'info'
          }, {
            position: new google.maps.LatLng(-33.91662347903106, 151.22879464019775),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.916365282092855, 151.22937399734496),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.91665018901448, 151.2282474695587),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.919543720969806, 151.23112279762267),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.91608037421864, 151.23288232673644),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.91851096391805, 151.2344058214569),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.91818154739766, 151.2346203981781),
            type: 'parking'
          }, {
            position: new google.maps.LatLng(-33.91727341958453, 151.23348314155578),
            type: 'library'
          }
        ];

        <%-- 이게 이게 기존에 위치 정보만 몰아서 등록해놨던 객체(변수명은 features)에 들어 있는
       		위치 정보 하나하나 불러다가 for문 돌리면서 각각 maker 생성해주는 구문 --%> 
        features.forEach(function(feature) {
          var marker = new google.maps.Marker({
            position: feature.position,
            icon: image,
            map: map
          });
        });
        
      }   
        <%-- 이거는 각 타입별로 다른 이미지 넣는 법. 각 타입의 이름과, 그 타입에 이미지 경로를 넣어주는 코딩.
        icons라는 객체를 우선 만들고, 그 객체 안에는 여러가지 타입 이름이 등록돼 있고, 그 타입 이름 안에는
        	이미지의 경로,위치를 넣어줌. 그러면 나중에 icons.type 라고 호출하면 미리 지정해 놓은
        	이미지 파일의 경로가 나오겠지
        var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
        var icons = {
          parking: {
            icon: iconBase + 'parking_lot_maps.png'
          },
          library: {
            icon: iconBase + 'library_maps.png'
          },
          info: {
            icon: iconBase + 'info-i_maps.png'
          }
        };
        
       	여기서 icon 속성이 해당 마커에 어떤 이미지 파일을 적용할지 알려주는 부분.
       	이 부분에 넣어주는 게, 아까 type별로 다르게 등록해놨던 이미지 파일들 경로
        features.forEach(function(feature) {
            var marker = new google.maps.Marker({
              position: feature.position,
              icon: icons[feature.type].icon,
              map: map
            });
          });
        }
        --%>
        
 
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap">
    </script>
  </body>
</body>
</html>
