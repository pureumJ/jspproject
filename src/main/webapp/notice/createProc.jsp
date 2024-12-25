<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_notice.jsp" %>
<jsp:useBean id="dao" class="com.notice.NoticeDAO" />
<jsp:useBean id="dto" class="com.notice.NoticeDTO" />
<jsp:setProperty property="*" name="dto"/>

<%
	boolean flag = dao.create(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 생성</title>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container mt-4">
		<div class="container p-5 my-5 border">
			<%
				if(flag) out.print("공지글 등록 성공");
				else out.print("공지글 등록 실패");
			%>
		</div>
		<button class="btn btn-dark" onclick="location.href='createForm.jsp'">다시시도</button>
		<button class="btn btn-dark" onclick="location.href='list.jsp'">목록으로</button>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>