<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_poll.jsp" %>
<jsp:useBean id="service" class="com.poll.PollService"/>
<%
	String[] itemnum = request.getParameterValues("itemnum");
	/* System.out.println(itemnum.length); */
	
	boolean flag = service.updateCount(itemnum);
	String msg = "투표가 처리 되지 못했습니다.";
	if(flag) msg = "투표가 정상 처리 되었습니다.";
%>
<script>
    alert("<%=msg%>");
    location.href = "pollItem.jsp?num="+<%=request.getParameter("num")%>;
</script>
 