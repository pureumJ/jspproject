<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>
<jsp:useBean id="dao" class="com.bbs.BbsDAO" />
<jsp:useBean id="dto" class="com.bbs.BbsDTO" />
<jsp:setProperty name="dto" property="*" /> 
<%
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	
	String col = request.getParameter("col");
	String word = request.getParameter("word");

	Map map = new HashMap();
	map.put("grpno", dto.getGrpno());
	map.put("ansnum", dto.getAnsnum());
	
	dao.upAnsnum(map);
	boolean flag = dao.createReply(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 답변 처리</title>
<script>
	function list(){
		let url = "list.jsp";
		url += "?nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		
		location.href = url;
	}
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp" />
<div class="container mt-4">
	<div class="container p-5 my-5 border">
		<%
			if(flag) out.print("답변 처리 성공");
			else out.print("답변 처리 실패");
		%>
	</div>
    <button type="button" class="btn btn-light" onclick="list()">목록으로</button>
</div>
</body>
</html>