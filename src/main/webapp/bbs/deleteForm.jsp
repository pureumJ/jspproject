<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
<script>
	function list(){
		let url = "list.jsp";
		url += "?nowPage=<%=request.getParameter("nowPage")%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		
		location.href = url;
	}
	function check(f){
		if(f.passwd.value.length == 0){
			f.passwd.focus();
			return false;
		}
	}
</script>
<style type="text/css">
	#red {
        color: red;
	}
</style>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container mt-4" >
		<h3 class="d-flex justify-content-center">게시글 삭제</h3>
		<div class="container p-5 my-5 border">
		
			<p id="red" class="d-flex justify-content-center mt-3"><strong>게시글을 삭제하면 복구할 수 없습니다!!</strong></p>
			
			<form action="deleteProc.jsp" method="post" onsubmit="return check(this)">
				<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno")%>">
				<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
				<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
				<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
				
				<div class="d-flex justify-content-center">
					<div class="d-flex justify-content-center">
						<input type="password" class="form-control" placeholder="비밀번호를 입력하세요." name="passwd">
					</div>	
					<div class="d-flex justify-content-center">
						<button class="btn btn-danger ms-3">삭제</button>
						<button class="btn btn-outline-danger ms-1" onclick="list()">취소</button>
					</div>	
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>