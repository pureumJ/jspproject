<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_notice.jsp"%>
<jsp:useBean id="dao" class="com.notice.NoticeDAO"/>
<jsp:useBean id="dto" class="com.notice.NoticeDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));

	Map map = new HashMap();
	map.put("noticeno", dto.getNoticeno());
	map.put("passwd", dto.getPasswd());
	
	boolean flag = false;
	boolean pflag = dao.passCheck(map);
	if(pflag) flag = dao.delete(dto.getNoticeno());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 삭제</title>
<script>
	function list(){
		let url = "list.jsp";
		url += "?nowPage=<%=request.getParameter("nowPage")%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		
		location.href= url;
	}
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp" />
<div class="container mt-4">
	<div class="container p-5 my-5 border">
		<%
	        if (!pflag) out.print("잘못된 비밀번호 입니다.");
	        else if (flag) out.print("게시글 삭제 성공");
	        else out.print("게시글 삭제 실패");
        %>
	</div>
	<%if (!pflag) {%><button class="btn btn-dark" onclick="history.back()">다시시도</button><%}%>
    <button type="button" class="btn btn-light" onclick="list()">목록으로</button>
</div>
</body>
</html>