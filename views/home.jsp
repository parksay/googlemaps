<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


</head>
<body>
<h1>
	Hello world!  
</h1>

<ul>
<li> <a href = "maps">맵 기본 코딩</a> </li>
<li> <a href = "markers">맵에 마커 아이콘 변경</a> </li>
<li> <a href = "geo1">지오코딩 테스트 첫 번째 => 주소로 검색 기능</a> </li>
<li> <a href = "geo2">지오코딩 테스트 두 번째 => 좌표를 입력하면 맵 중앙에 띄움</a> </li>
<li> <a href = "geo3">지오코딩 테스트 세 번째 => 주소 검색하면 좌표를 출력</a> </li>
<li> <a href = "geo4">지오코딩 테스트 네 번째 => 검색 결과 제한하기(옵션 걸기)</a> </li>
<li> <a href = "geo5">지오코딩 테스트 다섯 번째 => 두 지점 사이 경로 구하기</a> </li>
<li> <a href = "geo6">지오코딩 테스트 여섯 번째 => 검색으로 두 지점 사이 경로 구하기</a> </li>
<li> <a href = "geo7">지오코딩 테스트 일곱 번째 => 경로 구하는 함수 하나로</a> </li>
<li> <a href = "markclust1">마크 클러스터링 => 기본</a> </li>
<li> <a href = "locality1">행정구역 뽑아주기</a> </li>
<li> <a href = "locality2">행정구역 뽑아주는 array 알고리즘</a> </li>
<li> <a href = "locality3">행정구역 뽑아주는 array 알고리즘</a> </li>

</ul>

할 거:
1. 지오코딩-
	1)주소 검색하면 주소로부터 좌표 받기
	2)좌표 받아다가 DB에 넣기
2. 역지오코딩 -
	1)좌표 받아다가 맵에 넣어주면 주소로 띄워주기
자료형 확인
cood = typeof object
자료형 강제 변환 - String
cood = String(results[0].geometry.location)
자료형 강제 변환 - 숫자
cood = Number(results[0].geometry.location)
자료형 강제 변환 - int
cood = parseInt(object)
자료형 강제 변환 - float
cood = parseFloat(object)
</body>
</html>
