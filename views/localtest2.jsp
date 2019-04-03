<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdC1Oa4xE2ub87g1ouqeRxqapzLLg4shg&callback=initMap"></script>

<script>
function arraytest(){
		
	var arealist = [];
	var areacnt = [];
	var coodlist = ["1","9","3","4","9","4","2","9","9","9","5","2"];
	var index_list = 0;
	var index_cnt = 0;
	var max_cnt = 0;
	var output = document.getElementById('output');
	var flag;
	
		<%--일단 하나 넣어주고, 좌표 하나씩 꺼내 와서 그 좌표가 속해 있는 그 행정 구역을 들고 와서,
			기존 보기 리스트에 있는지 확인, 있으면 카운트 +1 없으면 새로운 보기 추가 --%>
		arealist[0] = coodlist[0];
		areacnt[0] = 1;
		<%-- 좌표를 하나 꺼내 와서--%>
		for( i = 0; i < coodlist.length; i = i + 1) {
			<%-- 보기 리스트에 있는 값들을 하나씩 꺼내 오면서--%>			
			for( j = 0; j < arealist.length; j = j + 1 ){
			<%-- 그 꺼내온 좌표가, 보기 리스트에 있는지 확인--%>
				flag = false;	
				if( coodlist[i] == arealist[j] ) {
					index_list = j;
					areacnt[j] = areacnt[j] + 1;
					flag = true;
					break;
				}
			}
			<%-- 보기 리스트에 있는 값들을 모두 꺼내오고 나서,
			아까 꺼내온 좌표랑 모든 보기 리스트랑 비교 해봤는데,
			같은 값을 찾을 수가 없었다면,
			즉 아까 꺼내온 좌표가 보기 리스트에 없다면,--%>
			if(!flag){
				<%-- 아까 꺼내온 좌표를 보기 리스트에 넣어달라. --%>
				arealist.push(coodlist[i]);
				areacnt.push(1);
			}
		}
		<%--아까 시작할 때 넣어놓은 거 땜에 1 세고 들어가는 거, 나중에 다시 빼주기 --%>
		areacnt[0] = areacnt[0] - 1;
		
		<%--  카운트 중에 가장 높은 값 불러오기
			그 자리에 해당하는 행정구역 값 반환하기 --%>
		for(k = 0; k < areacnt.length; k = k + 1){
			if( max_cnt <= areacnt[k] ){
				max_cnt = areacnt[k];
				index_cnt = k;
			}
		}
		
	output.innerHTML = arealist[index_cnt];
}

</script>

</head>
<body>
<input type=  "button" value = "검색 실행" onclick = "arraytest()">
<div id = "output"></div>

</body>
</html>