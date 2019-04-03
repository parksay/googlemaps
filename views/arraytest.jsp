<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
<%-- 이대로 하면 왜 안되고 이걸 함수 안에 넣으면 왜 되지? 
이거 구문 전체를 함수 안에 넣어가지고, 버튼이나 그런 걸로
간접 실행하면 또 되네. 다 각자 동등한 우선순위로 실행돼서 그런가?
그러니까, 각자가 다 static이 되는 건가?
var arraytest = 'a';
var output = document.getElementById('output');
output.innerHTML = arraytest;
--%>

<%-- 	이렇게 하면 123 나옴. arraytest라는 객체의 "a" 라는 속성의 string값
function test(){
var arraytest = { "a":"123","b":"456","c":"789"};
var output = document.getElementById('output');
output.innerHTML = arraytest.a;
}
 --%>
 
 <%-- 	이렇게 하면 a11 나옴.arraytest라는 객체에 담긴 "a" 라는 객체1에 담긴 객체1-1에 담긴 "a1"의 속성 값 string
 function test(){
	 var arraytest = { "a":{"a1":"a11","a2":"a22","a3":"a33"},"b":"456","c":"789"};
	 var output = document.getElementById('output');
	 output.innerHTML = arraytest.a.a1;
	 }
--%>
<%-- []는 배열 {}는 객체.
a = { "a1":"a11", "a2":"a22", "a3":"a33" }; 이러면 a라는 객체가 하나 생성됨.
그 객체는, a1, a2, a3이라는 속성을 갖는 거고, 그 속성의 값들은 각각 a11, a22, a33 이 되는 것임.
a = [ "a1", "a2", "a3" ]; 이러면 a라는 배열이 하나 생성됨.
그리고 그 배열은, 크기가 3이고, 0,1,2번의 자리에 각각 a1, a2, a3이라는 객체(string자료형)가 들어가 있는 것임.
--%> 

<%--  이렇게 하면 이제 arraytest라는 객체가 가지는 속성인 a라는 배열이 가지는 2번 자리의 객체가 a3이라는 속성의 string값
function test(){
	 var arraytest = { "a":[{"a1":"a11","a2":"a22"},{"a3":"a33", "a4":"a44"}],"b":"456","c":"789"};
	 var output = document.getElementById('output');
	 output.innerHTML = arraytest.a[1].a3;
	 }
</script>
<title>Insert title here</title>






</head>
<body>
<input type = "button" onclick = "test()" value = "테스트 실행">

<div id = "output"></div>

</body>
</html>