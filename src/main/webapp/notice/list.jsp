<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_notice.jsp" %>
<jsp:useBean id="dao" class="com.notice.NoticeDAO" />
<%
	//search------------------------------------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
	   word = "";
	}
	
	//paging------------------------------------------------------
	int nowPage = 1;
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int recordPerPage = 10;
	int sno = ((nowPage-1) * recordPerPage);
	int eno = 10;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	List<NoticeDTO> list = dao.list(map);
	int total = dao.total(col, word);
	
	String url = "list.jsp";
	String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<script>
	function read(noticeno) {
		let url = "read.jsp";
		url += "?noticeno=" + noticeno;
		url += "&nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		
		location.href = url;
	}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container mt-5">
		<h3 class="d-flex justify-content-center">공지글 목록</h3>
		
		<form action="./list.jsp" class="mt-3 mb-3">
	    	<div class="d-flex flex-row justify-content-end">
	    		<div class="ms-2">
	    			<select class="form-select" name="col" id="">
			            <option value="total" <%if(col.equals("total")) out.print("selected"); %>>전체</option>
			            <option value="wname" <%if(col.equals("wname")) out.print("selected"); %>>작성자</option>
			            <option value="title" <%if(col.equals("title")) out.print("selected"); %>>제목</option>
			            <option value="content" <%if(col.equals("content")) out.print("selected"); %>>내용</option>
			            <option value="title_content" <%if(col.equals("title_content")) out.print("selected"); %>>제목+내용</option>
			        </select>
	    		</div>
	    		<div class="ms-2">
	    			<input type="text" class="form-control" placeholder="검색어" name="word" value="<%=word%>" required="required">
	    		</div>
	    		<div class="ms-2">
					<button type="submit" class="btn btn-dark">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
					</button>
		            <button type="button" class="btn btn-dark" onclick="location.href='createForm.jsp'">글쓰기</button>
	    		</div>
	    	</div>
	    </form>
	    
	    <table class="shadow table table-hover mt-3">
	        <thead class="table-dark">
	        	<tr class="text-center">
					<th>No.</th>
					<th>제&nbsp;&nbsp;&nbsp;목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
		  	</thead>
	        <tbody>
	        <%if(list.size() == 0){ %>
	        	<tr><td colspan="6">등록된 공지글이 없습니다.</td></tr>
	        <%} else { 
	        	for(int i = 0; i < list.size(); i++){
	        		NoticeDTO dto = list.get(i);
	        %>
	            <tr>
	                <th class="text-center"><%=dto.getNoticeno() %></th>
	                <td>
	                	<a href="javascript:read('<%=dto.getNoticeno() %>')" style="text-decoration:none; color:black"><%=dto.getTitle() %></a>
	               		<% if(Utility.compareDay(dto.getRdate().substring(0, 10))) {
				    		/* out.print("<img src='../images/new.gif'>"); */ %>
				    		<span class="badge rounded-pill bg-warning">new</span>
				    	<% }%>
	               		
	               	</td>
	                <td class="text-center"><%=dto.getWname() %></td>
	                <td class="text-center"><%=dto.getCnt()%></td>
	                <td class="text-center"><%=dto.getRdate() %></td>
	            </tr>
	            
	           <%}
	           
	           }%>
	        </tbody>
	    </table>
		<button type="button" class="btn btn-dark" onclick="location.href='./createForm.jsp'">글쓰기</button>
		
	</div>
	<jsp:include page="/menu/bottom.jsp"/>
</body>
</html>