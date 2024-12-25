<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_poll.jsp" %>
<jsp:useBean id="service" class="com.poll.PollService" />

<%
	int num = 0;
	if (!(request.getParameter("num") == null || request.getParameter("num").equals(""))) {
	    num = Integer.parseInt(request.getParameter("num"));
	} else {
	    num = service.getMaxNum();
	}
	 
	PollDTO dto = service.read(num);
	 
	Vector<PollItemDTO> vlist = service.itemList(num);

	int sum = service.sumCount(num); 
	Vector<PollItemDTO> result = service.getView(num);
/* 	String color[] = {"bg-success","bg-info","bg-warning","bg-danger","bg-dark","bg-secondary"}; */
	String color[] = {"bg-success","bg-info","bg-warning","bg-secondary","bg-dark"};
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 하기</title>
<script>
	function checkItem(f) {
		let items = f.itemnum;
		let cnt = 0;
		
		for (let i = 0; i < items.length; i++) {
            if (items[i].checked) {
                cnt++;
            }
        }
        if (cnt == 0) {
            alert('항목을 체크해주세요');
            return false;
        }
	}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="d-flex justify-content-center container mt-5">
		<div style="width:900px">
			<h3 class="d-flex justify-content-center mb-4">투표 하기</h3>
			<% if(dto != null) {%>
				<div class="container p-5 border rounded-3 d-flex align-items-center flex-column" style="width:900px">
					<label class="m-10 h4 d-flex justify-content-center"><strong>Q. <%=dto.getQuestion() %></strong></label>
					<form action="pollProc.jsp" class="p-3" onsubmit="return checkItem(this)">
						<input type="hidden" name="num" value="<%=num%>" />
						<div style="width:100%">
						
							<%
					            for (int i = 0; i < vlist.size(); i++) {
					            	
					                PollItemDTO idto = vlist.get(i);
					 
					                if (dto.getType() == 1) { 
					     	%>
							            <div class="form-check">
							                <input type="checkbox" class="form-check-input" id='check<%=i%>'
							                       name='itemnum' value='<%=idto.getItemnum()%>'>
							                <label class="form-check-label" for='check<%=i%>'><%=idto.getItem()%></label>
							            </div>
							  
						            <%
					                } else {
						            %>
							            <div class="form-check">
							                <input type="radio" class="form-check-input" id='radio<%=i%>' 
							                       name="itemnum" value="<%=idto.getItemnum()%>">
							                <label class="form-check-label" for='radio<%=i%>'><%=idto.getItem()%></label>
										</div>
					         	<%
					               }
					            } %>
					            
						</div>
				            <% 
				            LocalDate now = LocalDate.now(); 
				            LocalDate edate_ = LocalDate.parse(dto.getEdate()); %>
							
							<div class="d-flex justify-content-center mt-5">         		
								<%              		
					            if (dto.getActive() == 0 || now.isAfter(edate_)) { 
					            %>
				 
						            <button type='button' class="btn btn-dark m-1 " disabled>투표 종료</button>
				            	<%
					            } else {
						            %>
						            <button class="btn btn-dark m-1">투표</button>
						            <%
					            }
					            %>
				            	<button type="button" class="btn btn-outline-dark m-1" data-bs-toggle="modal" data-bs-target="#myModal">결과</button>
				            	
			            	</div> 
					</form>
				</div>
				<div class="d-flex justify-content-end">
					<a type="button" class="btn btn-dark m-1" onclick="location.href='list.jsp'">목록으로</a>
				</div>
			<%} %>
		</div>
	</div>
	<jsp:include page="/menu/bottom.jsp"/>
</body>
</html>

<%
if (dto != null) { // 등록된 설문이 있는 경우
%>
 
<!-- 투표 결과 Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">
 
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">투표 결과 보기</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
 
            <!-- Modal body -->
            <div class="modal-body">
 
                <ul class="list-group">
                    <li class="list-group-item"><strong>Q : <%=dto.getQuestion()%></strong></li>
                    <li class="list-group-item">총 투표자 : <%=sum%>명
                    </li>
                </ul>
 
                <ol class="list-group list-group-numbered">
                    <%
                    if (sum > 0) {
                        for (int i = 0; i < result.size(); i++) {
                            PollItemDTO idtor = result.get(i);
                            String item = idtor.getItem();//아이템 
                            /* int j = (int) (Math.random() * (color.length - 1) + 0); */
                            String hRGB = color[i];
                            double count = idtor.getCount();//투표수
                            int ratio = (int) (Math.ceil(count / sum * 100));
 
                            //System.out.println("radio:" + ratio);
                    %>
 
                    <li class="list-group-item"><%=item%>
                        <div class="progress">
                            <div class="progress-bar <%=hRGB%>" style="width:<%=ratio%>%"></div>
                        </div> (<%=(int) count%>)
                    </li>
                    <%
                        } //for
                        out.println("</ol>");
                    } else {
                        out.println("<ul class='list-group'><li class='list-group-item'>투표를 먼저 해주세요</li></ul>");
                    }
                    %>
            </div>
 
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Close</button>
            </div>
 
        </div>
    </div>
</div>
<!-- Modal end -->
 
<%
}
%>