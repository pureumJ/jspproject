<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp" %>
<jsp:useBean id="bdao" class="com.bbs.BbsDAO" />
<jsp:useBean id="ndao" class="com.notice.NoticeDAO" />
<jsp:useBean id="service" class="com.poll.PollService" />


<%
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));

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

	List<BbsDTO> nlist = bdao.nList(map);
	List<NoticeDTO> list = ndao.list(map);
	
	Vector<PollDTO> plist = service.getList(map);
	Iterator<PollDTO> iter = plist.iterator();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP기반 홈페이지</title>
<script>
	function readBbs(bbsno){
	    let url = "bbs/read.jsp";
	    url += "?bbsno=" + bbsno;
		url += "&nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		
		location.href = url;
	}
	function readNotice(noticeno) {
		let url = "notice/read.jsp";
		url += "?noticeno=" + noticeno;
		url += "&nowPage=<%=nowPage%>";
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		
		location.href = url;
	}
	function readPoll(num){
		let url = "poll/pollItem.jsp";
		url += "?num="+num;
		
		location.href = url;
	}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	
	<div class="container mt-3">
		
		<div class="h4 mt-4">최신글 보기</div>
		<div class="row">
			<div class="shadow rounded col m-3" style="height:280px" >
				<div class="row">
					<div class="h5 col ms-3 mt-3">게시글</div>
					<a href="<%=root%>/bbs/list.jsp" class="col mt-3 me-3 text-end" style="text-decoration:none; color:gray">+ 더보기</a>
				</div>
				<div class="m-3">
					<table class="table">
	        			<thead class="table table-dark">
				        	<tr class="text-center">
								<th>제&nbsp;&nbsp;&nbsp;목</th>
								<th>작성자</th>
								<th>조회수</th>
								<!-- <th>작성일</th> -->
							</tr>
		  				</thead>
        			<tbody>
				        <%if(nlist.size() == 0){ %>
				        	<tr><td colspan="6">등록된 게시글이 없습니다.</td></tr>
				        <%} else { 
				        	for(int i = 0; i < 3; i++){
				        		if(i == nlist.size()) break;
				        		BbsDTO bdto = nlist.get(i);
				        %>
				            <tr>
				                <td>
				                	<a href="javascript:readBbs('<%=bdto.getBbsno()%>')" style="text-decoration:none; color:black"><%=bdto.getTitle() %></a>
				               	</td>
				                <td class="text-center"><%=bdto.getWname() %></td>
				                <%-- <td class="text-center"><%=bdto.getWdate() %></td> --%>
				                <td class="text-center"><%=bdto.getViewcnt() %></td>
				            </tr>
				            
				           <%}
				           
				           }%>
				        </tbody>
				    </table>
				</div>
			</div>
			<div class="shadow rounded col m-3" style="height:280px">
				<div class="row">
					<div class="h5 col mt-3 ms-3">공지사항</div>
					<a href="<%=root %>/notice/list.jsp" class="col mt-3 me-3 text-end" style="text-decoration:none; color:gray">+ 더보기</a>
				</div>
				<div class="m-3">
					<table class="table">
				        <thead class="table-dark">
				        	<tr class="text-center">
								<th>제&nbsp;&nbsp;&nbsp;목</th>
								<th>작성자</th>
								<th>조회수</th>
							</tr>
					  	</thead>
				        <tbody>
				        <%if(list.size() == 0){ %>
				        	<tr><td colspan="6">등록된 공지글이 없습니다.</td></tr>
				        <%} else { 
				        	for(int i = 0; i < list.size(); i++){
				        		if(i == list.size()) break;
				        		NoticeDTO ndto = list.get(i);
				        %>
				            <tr>
				                <td>
				                	<a href="javascript:read('<%=ndto.getNoticeno() %>')" style="text-decoration:none; color:black"><%=ndto.getTitle() %></a>
				               	</td>
				                <td class="text-center"><%=ndto.getWname() %></td>
				                <td class="text-center"><%=ndto.getCnt()%></td>
				            </tr>
				            
				           <%}
				           
				           }%>
				        </tbody>
				    </table>
				</div>
			</div>
		</div>
		<div>
			<div class="shadow rounded row m-1">
				<div class="h5 col mt-3 ms-3">투표</div>
				<a href="<%=root %>/poll/list.jsp" class="col mt-3 me-3 text-end" style="text-decoration:none; color:gray">+ 더보기</a>
				<div class="container mt-3 d-flex flex-wrap">
					<%if(plist.size() == 0){ %>
				    	<div class="container p-5 my-5 border">
							등록된 투표가 없습니다.
						</div>
				    <%} else {%>
				    	<% for(int i = 0; i < 4; i++){
				    		if(i == plist.size()) break;
				    		PollDTO pdto = plist.get(i); 
				    		%>
				    		
				    		<div class="card ms-4 mb-5" style="width:280px;height:180px">
				    			<div class="card-body">
				    				<h5 class="card-title"><strong><%=pdto.getQuestion() %></strong></h5>
				    				<p class="card-text">투표 진행 기간<br><%=pdto.getSdate() %>~ <%=pdto.getEdate() %></p>
				    				<a href="javascript:readPoll('<%=pdto.getNum()%>')" class="btn btn-dark position-relative">
				    					투표 하기
				    					<%
				    						LocalDate now = LocalDate.now(); 
							            	LocalDate edate_ = LocalDate.parse(pdto.getEdate());
							            	if (pdto.getActive() == 0 || now.isAfter(edate_)) { 
				    					%>
				    							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-secondary">기간종료</span>
				    					<%	} else { %>
				    							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-success">진행중</span>
				    					<%  } %>
			    					</a>
				    			</div>
				    		</div>
				    	<% } %>
				   <% } %>
				   </div>
			   </div>
		</div>
	</div>
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>