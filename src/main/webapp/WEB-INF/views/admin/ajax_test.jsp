<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script>
var allData;
$(document).ready(function() {
	$(document).on("click", "input:radio[name='result']", function(){
	var targetId = $(this).attr('id');
    var keyname = "keyword";
    var obj = {};
    obj[keyname] = targetId;
		$.ajax({
      url : "<c:url value='/admin/searchOneAjax' />",
      type : "post",
      data : JSON
          .stringify(obj),
      dataType : "json",
      contentType : "application/json",
      success : function(data) {
        var strContent = "<td>" + data[0].a_name + "</td><td>" + data[0].a_phone + "</td>"
        $("#content").html(strContent);
      },
      error : function(
          errorThrown) {
        alert(errorThrown.statusText);
      }
    });
	});
	
	$("#AjaxTest").on("click", function() {
	  var obj = {
	    'player' : 'kane',
	    'age' : 30
	  };
	  $.ajax({
	    url : "<c:url value='/admin/goTest' />",
	    type : "post",
	    data : JSON.stringify(obj),
	    dataType : "json",
	    contentType : "application/json",
	    success : function(data) {
	      alert(data.goal);
	    },
	    error : function(errorThrown) {
	      alert(errorThrown.statusText);
	    }
	  });
});

$("#search").on("click", function() {
    var keyword = $("#keyword").val().trim();
    if (keyword == "") {
      alert('아이디를 입력하세요')
    } else {
      var keyname = "keyword";
      var obj = {};
      obj[keyname] = keyword;
      $.ajax({
        url : "<c:url value='/admin/searchAjax' />",
        type : "post",
        data : JSON
            .stringify(obj),
        dataType : "json",
        contentType : "application/json",
        success : function(data) {
          $("#result").empty();
          for (var i = 0; i < data.length; i++) {
            if(i == 0){
            	var str = "<label><input type='radio' id='" + data[i].a_id + "' name='result' class='result' checked>"
                + data[i].a_id
                + "</label><br>";
	            console.log(str);
	            $("#result").append(str);
            	var strContent = "<td>" + data[i].a_name + "</td><td>" + data[i].a_phone + "</td>"
            	$("#content").html(strContent);
            } else {
            	var str = "<label><input type='radio' id='" + data[i].a_id + "' name='result'>"
                + data[i].a_id
                + "</label><br>";
	            $("#result").append(str);
            }
          }
        },
        error : function(
            errorThrown) {
          alert(errorThrown.statusText);
        }
      });
    }
  });
});
</script>
</head>
<body>
	<table>
		<tr>
			<th>아이디</th>
		</tr>
		<tr>
			<td>
				<!-- 어드민검색 영역-->
				<table>
					<tr>
						<td><input type="text" name="keyword" id="keyword"></td>
					</tr>
					<tr>
						<td><input type="button" name="AjaxTest" id="AjaxTest"
							value="AjaxTest"></td>
					</tr>
					<tr>
						<td><input type="button" name="search" id="search"
							value="조건검색"></td>
					</tr>
					<tr>
						<td>
							<!-- 검색 결과 보이는곳 -->
							<div id="result"></div> <!-- 검색 결과 보이는곳 여기까지-->
						</td>
					</tr>

				</table> <!-- 어드민검색 영역 여기까지-->
			</td>
		</tr>
	</table>
	<!-- 조회정보표시영역 -->
	<table border="1">
		<tr>
			<th>닉네임</th>
			<th>전화번호</th>
		</tr>
		<!-- 검색 결과 보이는곳 -->
		<tr id="content"></tr> <!-- 검색 결과 보이는곳 여기까지-->
		
	</table> <!-- 조회정보표시영역 여기까지-->
</body>
</html>







