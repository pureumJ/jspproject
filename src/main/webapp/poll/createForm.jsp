<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 생성</title>

<script>
	let i = 1;
	let num = 0;
	
	function addItem(){
		if(i > 4) return;
		i++;
		let sp = document.createElement('span');
		sp.className = 'input-group-text';
		sp.innerText = i;
		
		let el = document.createElement('input');
		el.type='text';
		el.className = 'form-control';
		el.name = "items";
		el.id = `item${i}`;
		el.placeholder='투표 항목을 입력하세요';
		
		let items = document.getElementById('items-div');
		let dive = document.createElement('div');
		dive.className = 'input-group mt-1';
		dive.appendChild(sp);
		dive.appendChild(el);
		items.appendChild(dive);
		
	}
	function check(f){
		if(f.question.value.length == 0){
			f.question.focus();
			return false;
		}
		if(f.sdate.value.length == 0){
			f.sdate.focus();
			return false;
		}
		if(f.edate.value.length == 0){
			f.edate.focus();
			return false;
		}
		if(document.querySelector('#item1').value.length == 0){
			document.querySelector('#item1').focus();
			return false;
		}
		if(document.querySelector('#items-div').childElementCount < 1){
			document.querySelector('#items-div').focus();
			alert('항목을 1개이상 입력하세요');
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container mt-5">
		<h3 class="d-flex justify-content-center">투표 생성</h3>
		<form action="createProc.jsp" method="post" onsubmit="return check(this)">
			<div class="input-group mt-3">
				<label class="input-group-text" for="question">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;목&nbsp;&nbsp;</label> 
       			<input type="text" class="form-control" id="question" placeholder="투표 제목 입력" name="question">
			</div>
			
			<div class="mt-3">
				* 투표 항목은 5개 까지 입력 가능합니다!
		        <!-- <span class="">투표 항목</span> -->
		        <div class="input-group">
		            <span class="input-group-text">1</span> 
		            <input type="text" class="form-control" name="items" id="item1" placeholder="투표 항목을 입력하세요">
		            <button type="button" class="btn btn-dark" onclick="addItem()">+</button>
		        </div>
		        <div id="items-div"></div>
		    </div>
			
			<div id="items-div"></div>
			
			<div class="input-group mt-3">
				<label class="input-group-text" for="sdate">&nbsp;&nbsp;시작일&nbsp;&nbsp;</label> 
       			<input type="date" class="form-control" id="sdate" name="sdate">
			</div>
			<div class="input-group mt-3">
				<label class="input-group-text" for="edate">&nbsp;&nbsp;종료일&nbsp;&nbsp;</label> 
       			<input type="date" class="form-control" id="edate" name="edate">
			</div>
			
			<!-- <div class="input-group mt-3">
		        <label class="input-group-text">복수 투표</label>
		        <div class="form-check">
		            <input type="radio" name="type" value="1"
		                class="form-check-input m-2" id="yes" checked>
		            <label class="form-check-label" for="yes">yes</label>
		        </div>
		        <div class="form-check">
		            <input type="radio" name="type" value="0"
		                class="form-check-input m-2" id="no"> 
		            <label class="form-check-label" for="no">no</label>
		        </div>
	        </div> -->
	        
	        <div class="mt-3">
		        <label>* 복수 투표</label>
	            <input type="checkbox" name="type" value="1" class="form-check-input m-2" id="yes" checked>
	            <label class="form-check-label" for="yes">yes</label>
	        </div>
		        <!-- <div class="form-check">
		            <input type="radio" name="type" value="0"
		                class="form-check-input m-2" id="no"> 
		            <label class="form-check-label" for="no">no</label>
		        </div>
	        </div> -->
	        
	        
	        <!-- <div class="input-group mt-3 mb-3">
				<label class="input-group-text" for="inputGroupSelect01">복수투표</label>
				<select class="form-select" id="inputGroupSelect01">
			    	<option selected name="type" value="1" id="yes">yes</option>
			    	<option value="0" id="no">no</option>
				</select>
			</div> -->
		    
		    <div class= "d-flex justify-content-end">
	        <input type="submit" class="btn btn-dark btn-sm ms-1" value="등록">
	        <input type="reset" class="btn btn-dark btn-sm ms-1" value="초기화">
	        <input type="button" class="btn btn-dark btn-sm ms-1" value="취소" onclick="location.href='list.jsp'">
	    </div>
		</form>
	</div>
	<jsp:include page="/menu/bottom.jsp"/>
</body>
</html>