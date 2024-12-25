<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp" %>
<jsp:useBean id="dao" class="com.bbs.BbsDAO"/>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));

	BbsDTO dto = dao.readReply(bbsno);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 작성</title>
<script>
	function list(){
		let url = "list.jsp";
		url += "?nowPage=<%=request.getParameter("nowPage")%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		
		location.href = url;
	}
	function check(f){
		if(f.wname.value.length == 0){
			f.wname.focus();
			return false;
		}
		if(f.title.value.length == 0){
			f.title.focus();
			return false;
		}
		if(f.passwd.value.length == 0){
			f.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp" />
<div class="container mt-4">
	<h3 class="d-flex justify-content-center">게시글 답변 등록</h3>
	<form action="replyProc.jsp" method="post" onsubmit="return check(this)">
		<input type="hidden" name="bbsno" value="<%=bbsno%>">
		<input type="hidden" name="grpno" value="<%=dto.getGrpno() %>">
		<input type="hidden" name="indent" value="<%=dto.getIndent() %>">
		<input type="hidden" name="ansnum" value="<%=dto.getAnsnum() %>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
		<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
		<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
		
		<div class="input-group mt-4 mb-3">
			<label for="wname" class="input-group-text">작성자</label>
			<input type="text" class="form-control" id="wname" placeholder="작성자를 입력하세요." name="wname">
		</div>
		<div class="input-group mb-3">
			<label for="title" class="input-group-text">제&nbsp;&nbsp;&nbsp;목</label>
			<input type="text" class="form-control" id="title" value="[답글] " name="title">
		</div>
		<div class="input-group mb-3">
			<label for="wname" class="input-group-text">내&nbsp;&nbsp;&nbsp;용</label>
			<textarea class="form-control" rows="10" id="content" name="content"></textarea>
		</div>
		<div class="input-group mb-3">
			<label for="passwd" class="input-group-text">비밀번호</label>
			<input type="password" class="form-control" id="passwd" placeholder="Enter Password.." name="passwd">
		</div>
		
		<div class= "d-flex justify-content-end">
	        <input type="submit" class="btn btn-dark btn-sm" value="등록">
	        <input type="reset" class="btn btn-dark btn-sm ms-1" value="초기화">
	        <button class="btn btn-outline-dark ms-1" onclick="list()">취소</button>
	    </div>
	</form>
</div>
</body>
</html>