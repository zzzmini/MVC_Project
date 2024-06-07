<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL 선언부 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL if</title>
</head>
<body>
<!-- JSTP if 조건 -->
<c:if test="true">
	true이므로 실행한다.
</c:if>
<hr>

<!-- query string 방식 -->
<a href="/zzz/step1?age=10&nick=펭수">step1을 다시 호출</a><br><br>
나이: ${param.age} <br>
닉네임: ${param.nick}
<br><br>

<c:if test="${param.age > 5 && param.nick == '펭수'}">
	나이가 5세를 초과합니다. 닉네임은 펭수입니다.
</c:if>

</body>
</html>