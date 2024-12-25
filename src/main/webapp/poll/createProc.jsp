<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_poll.jsp"%>
<jsp:useBean id="service" class="com.poll.PollService"/>
<jsp:useBean id="dto" class="com.poll.PollDTO"/>
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="idto" class="com.poll.PollItemDTO"/>
<jsp:setProperty property="*" name="idto"/>
<%
	boolean flag = service.create(dto, idto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 생성</title>
</head>
<body>
<jsp:include page="/menu/top.jsp" />
	<div class="container mt-4">
		<div class="container p-5 my-5 border">
			<%
				if(flag) out.print("투표 등록 성공");
				else out.print("투표 등록 실패");
			%>
		</div>
		<button class="btn btn-dark" onclick="location.href='createForm.jsp'">다시시도</button>
		<button class="btn btn-dark" onclick="location.href='list.jsp'">목록으로</button>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>