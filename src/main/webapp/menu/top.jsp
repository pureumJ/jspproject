<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String root = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP기반 홈페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="<%=root%>/index.jsp"><strong>Pureum.</strong></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">게시판</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=root%>/bbs/list.jsp">게시글 목록</a></li>
            <li><a class="dropdown-item" href="<%=root%>/bbs/createForm.jsp">게시글 생성</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">투표</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=root%>/poll/list.jsp">투표 목록 </a></li>
            <li><a class="dropdown-item" href="<%=root%>/poll/createForm.jsp">투표 생성 </a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">공지사항</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%=root%>/notice/list.jsp">공지글 목록</a></li>
            <li><a class="dropdown-item" href="<%=root%>/notice/createForm.jsp">공지글 생성</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=root%>/webgame/whack-a-mole.jsp">Web Game</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>