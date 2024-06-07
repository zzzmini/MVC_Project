<%@ page import="java.util.*"%>
<%@ page import="kr.co.zzz.jspTest.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL 선언부 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		CarDto car1 = new CarDto("가1234", "소나타", 2000);
		request.setAttribute("dto", car1);
	%>
	<h3>EL(Expression Language) 기본</h3>

	<!-- 변수 출력 -->
	<strong>1. CarDto instance에서 변수 model 출력</strong>
	<br> ${dto.model}
	<hr>

	<!-- 리스트로 변수 출력 -->
	<%
		ArrayList<CarDto> list = new ArrayList<>();
		list.add(new CarDto("나2345", "테슬라", 4500));
		session.setAttribute("carList", list);
	%>
	<strong>2. CarDto instance에서 List로 변수 출력</strong>
	<br> ${sessionScope.carList[0].model}
	<hr>

	<!-- 해쉬맵으로 변수 출력 -->
	<%
		HashMap<String, CarDto> map = new HashMap<String, CarDto>();
		map.put("car1", new CarDto("다3333", "모닝", 1000));
		//컨트롤러에서 할당했다고 가정
		session.setAttribute("carMap", map);
	%>
	<strong>3. 세션영역의 HashMap 요소에 접근</strong>
	<br> ${sessionScope.carMap.car1.model}
</body>
</html>