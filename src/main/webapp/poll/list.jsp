
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_poll.jsp"%>
<jsp:useBean id="service" class="com.poll.PollService" />
<% 
	//검색관련------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	 
	if (col.equals("total")) {
	    word = "";
	} 
	 
	//페이지관련-----------------------
	int nowPage = 1;//현재 보고있는 페이지
	if (request.getParameter("nowPage") != null) {
	    nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;//한페이지당 보여줄 레코드갯수
	 
	int sno = ((nowPage - 1) * recordPerPage); //디비에서 가져올 시작위치
	int eno = 5;//디비에서 가져올 레코드 갯수
	 
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	 
	//설문 목록
	Vector<PollDTO> list = service.getList(map);
	Iterator<PollDTO> iter = list.iterator();
	 
	int total = service.total(col, word);
	 
	String url = "poll.jsp";
	 
	String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 목록</title>
<script>
	function read(num){
		let url = "pollItem.jsp";
		url += "?num="+num;
		
		location.href = url;
	}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container mt-5">
		<h3 class="d-flex justify-content-center">투표 목록</h3>
		<form action="./list.jsp" class="mt-3 mb-3">
	    	<div class="d-flex flex-row justify-content-end">
	    		<div class="ms-2">
	    			<select class="form-select" name="col" id="">
			            <option value="total" <%if(col.equals("total")) out.print("selected"); %>>전체</option>
			            <option value="sdate" <%if(col.equals("sdate")) out.print("selected"); %>>시작일</option>
			            <option value="edate" <%if(col.equals("edate")) out.print("selected"); %>>종료일</option>
			            <option value="question" <%if(col.equals("question")) out.print("selected"); %>>투표내용</option>
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
		            <button type="button" class="btn btn-dark" onclick="location.href='createForm.jsp'">투표 생성</button>
	    		</div>
	    	</div>
	    </form>
	    
	    <%if(list.size() == 0){ %>
	    	<div class="container p-5 my-5 border">
				등록된 투표가 없습니다.
			</div>
	    <%} else {%>
	    	<div class="container mt-3 d-flex flex-wrap">
	    	
	    	<% for(int i = 0; i < list.size(); i++){
	    		PollDTO dto = list.get(i); 
	    		%>
	    		
	    		<div class="shadow card m-3" style="width:285px">
	    			<img class="card-img-top" src="../images/question.png" alt="Card image" style="width:100%">
	    			<div class="card-body">
	    				<h5 class="card-title"><strong><%=dto.getQuestion() %></strong></h5>
	    				<p class="card-text">투표 진행 기간<br><%=dto.getSdate() %> ~ <%=dto.getEdate() %></p>
	    				<a href="javascript:read('<%=dto.getNum()%>')" class="btn btn-dark position-relative">
	    					투표 하기
	    					<%
	    						LocalDate now = LocalDate.now(); 
				            	LocalDate edate_ = LocalDate.parse(dto.getEdate());
				            	if (dto.getActive() == 0 || now.isAfter(edate_)) { 
	    					%>
	    							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary">기간종료</span>
	    					<%	} else { %>
	    							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-success">진행중</span>
	    					<%  } %>
    					</a>
	    			</div>
	    		</div>
	    	<% } %>
	    	</div>
	   <% } %>
	</div>
	<jsp:include page="/menu/bottom.jsp"/>
</body>
</html>