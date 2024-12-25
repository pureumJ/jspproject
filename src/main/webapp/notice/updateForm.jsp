<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_notice.jsp" %>
<jsp:useBean id="dao" class="com.notice.NoticeDAO"/>
<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));
	NoticeDTO dto = dao.read(noticeno);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 수정</title>
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
		<h3 class="d-flex justify-content-center">공지글 수정</h3>
		<form action="updateProc.jsp" method="post" onsubmit="return check(this)">
		  	<input type="hidden" name="noticeno" value="<%=dto.getNoticeno()%>">
		  	<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
		  	<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
		  	<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
		    
		    <div class="input-group mt-4 mb-3">
		      <label for="wname" class="input-group-text">작성자</label>
		      <input type="text" class="form-control" id="wname" value="<%=dto.getWname()%>" name="wname">
		    </div>
		    <div class="input-group mb-3">
		      <label for="title" class="input-group-text">제&nbsp;&nbsp;&nbsp;목</label>
		      <input type="text" class="form-control" id="title" value="<%=dto.getTitle()%>" name="title">
		    </div>
		    <div class="input-group mb-3">
		      <label for="content" class="input-group-text">내&nbsp;&nbsp;&nbsp;용</label>
		      <textarea class="form-control" rows="5" id="content" name="content"><%=dto.getContent()%></textarea>
		    </div>
		    <div class="input-group mb-3">
		      <label for="passwd" class="input-group-text">비밀번호</label>
		      <input type="password" class="form-control" id="passwd" placeholder="비밀번호를 입력하세요." name="passwd">
		    </div>
		    
		    <div class= "d-flex justify-content-end">
			    <button type="submit" class="btn btn-dark ms-1">수정</button>
			    <button type="reset" class="btn btn-light ms-1" onclick="list()">취소</button>
			</div>		 
	  	</form>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>