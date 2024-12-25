<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>
<jsp:useBean id="dao" class="com.bbs.BbsDAO" />
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	
	dao.upViewcnt(bbsno);
	
	BbsDTO dto = dao.read(bbsno);
	BbsDTO pdto = dao.readPrior(bbsno);
	BbsDTO ndto = dao.readNext(bbsno);
	
	String content = dto.getContent().replaceAll("\r\n", "<br>");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 조회</title>
<script>
	function read(bbsno){
		let url = "read.jsp";
		url += "?bbsno="+bbsno;
		url += "&nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
	       
	    location.href=url;
	}
	function list() {
		let url = "list.jsp";
		url += "?nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		
		location.href = url;
	}
	function update(){
		let url = "updateForm.jsp";
		url += "?nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&bbsno=<%=bbsno%>";
		
		location.href= url;
	}
	function del() {
		let url = "deleteForm.jsp";
		url += "?nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&bbsno=<%=bbsno%>";
		
		location.href= url;
	}
	function reply(){
		let url = "replyForm.jsp";
		url += "?nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&bbsno=<%=bbsno%>";
		
		location.href= url;
	}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container mt-5">
		<!-- 게시글 조회 -->
		<h3 class="d-flex justify-content-center">게시글 조회</h3>
		<ul class="list-group mt-4 mb-3">
			<li class="list-group-item">작성자 : <%=dto.getWname()%></li>
			<li class="list-group-item">제&nbsp;&nbsp;&nbsp;목 : <%=dto.getTitle() %></li>
			<li class="list-group-item" style="height: 200px; overflow-y: scroll"><%=content %></li>
			<li class="list-group-item">조회수 : <%=dto.getViewcnt() %></li>
			<li class="list-group-item">등록일 : <%=dto.getWdate() %></li>
		</ul>
		<div class= "d-flex justify-content-end">
			<button class="btn btn-dark" onclick="location.href='createForm.jsp'">글쓰기</button>
		    <button class="btn btn-dark ms-1" onclick="update()">수정</button>
		    <button class="btn btn-dark ms-1" onclick="del()">삭제</button>
		    <button class="btn btn-dark ms-1" onclick="reply()">답변</button>
		    <button class="btn btn-outline-dark ms-1" onclick="list()">목록으로</button>
		</div>
		<br/>
	 	<!-- 이전 & 다음 게시글 목록 -->
		<table class="table table-hover mt-4">
			<tbody>
				<%if(pdto == null){ %> 
					<tr>
						<td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16">
							  	<path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
							</svg>
							이전글
						</td>
						<td colspan="6">이전 게시글이 없습니다.</td>
					</tr>
				<%} else {%> 
					<tr>
						<td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16">
							  	<path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
							</svg>
							이전글
						</td>
	    				<td><a href="javascript:read('<%=pdto.getBbsno() %>')" style="text-decoration:none; color:black"><%=pdto.getTitle() %></a></td>
	   					<td ><%=pdto.getWname() %></td>
	   					<td ><%=pdto.getViewcnt() %></td>
	   					<td ><%=pdto.getWdate() %></td>
					</tr>
				<%} %>
				
				<%if(ndto == null){ %> 
					<tr>
						<td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
	 								<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
							</svg>
							다음글
						</td>
						<td colspan="6">다음 게시글이 없습니다.</td>
					</tr>
				<%} else {%> 
					<tr>
						<td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
	 								<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
							</svg>
							다음글
						</td>
	    				<td><a href="javascript:read('<%=ndto.getBbsno() %>')" style="text-decoration:none; color:black"><%=ndto.getTitle() %></a></td>
	   					<td ><%=ndto.getWname() %></td>
	   					<td ><%=ndto.getViewcnt() %></td>
	   					<td ><%=ndto.getWdate() %></td>
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>