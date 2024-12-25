<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 생성</title>
<script>
	function check(f){
		if(f.wname.value.length == 0){
			f.wname.focus();
			return false;
		}
		if(f.title.value.length == 0){
			f.title.focus();
			return false;
		}
		if(f.passwd.value.length == 0){
			f.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp"/>

<div class="container mt-5">
	<h3 class="d-flex justify-content-center">게시글 생성</h3>
	<form action="createProc.jsp" method="post" onsubmit="return check(this)">
	    <div class="input-group mt-4 mb-3">
	        <label for="name" class="input-group-text">작성자</label>
	        <input class="form-control" id="wname" type="text" placeholder="작성자를 입력하세요." name="wname">
	    </div>
	    <div class="input-group mb-3">
	        <label for="title" class="input-group-text">제&nbsp;&nbsp;&nbsp;목</label>
	        <input class="form-control" id="title" type="text" placeholder="제목을 입력하세요." name="title">
        </div>
        <div class="input-group mb-3">
	        <label for="content" class="input-group-text">내&nbsp;&nbsp;&nbsp;용</label>
	        <textarea class="form-control" id="content" rows="10" placeholder="내용을 입력하세요." name="content"></textarea>
		</div>
	        
	    <div class="input-group mb-3">  
	        <label for="password" class="input-group-text">비밀번호</label>
            <input class="form-control" id="passwd" type="password" placeholder="비밀번호를 입력하세요." name="passwd">
	    </div>

	    <div class= "d-flex justify-content-end">
	        <input type="submit" class="btn btn-dark btn-sm ms-1" value="등록">
	        <input type="reset" class="btn btn-dark btn-sm ms-1" value="초기화">
	        <input type="button" class="btn btn-dark btn-sm ms-1" value="취소" onclick="location.href='list.jsp'">
	    </div>
	</form>
</div>

</body>
</html>