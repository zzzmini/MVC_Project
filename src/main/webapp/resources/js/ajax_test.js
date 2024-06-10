$(document).ready(function() {
	var allData;
	const contextPath = sessionStorage.getItem("contextpath");
	console.log(contextPath);
	
	$(document).on("click", "input:radio[name='result']", function(){
	var targetId = $(this).attr('id');
    var keyname = "keyword";
    var obj = {};
    obj[keyname] = targetId;
		$.ajax({
      url : `${contextPath}/admin/searchOneAjax`,
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
	    url : `${contextPath}/admin/goTest`,
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
        url : `${contextPath}/admin/searchAjax`,
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