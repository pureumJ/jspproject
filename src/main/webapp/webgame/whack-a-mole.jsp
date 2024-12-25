<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>두더지 게임</title>
<script src="game.js" defer></script>
</head>
	<style>
	  .cell {
	    display: inline-block;
	    position: relative;
	    width: 200px;
	    height: 200px;
	    background: "yellow";
	    overflow: hidden;
	  }
	  .gopher,
	  .bomb {
	    width: 200px;
	    height: 200px;
	    bottom: 0;
	    position: absolute;
	    transition: bottom 1s;
	  }
	  .gopher {
	    background: url("../images/gopher.png") center center no-repeat;
	    background-size: 200px 200px;
	  }
	  .dead {
	    background: url("../images/dead_gopher.png") center center no-repeat;
	    background-size: 200px 200px;
	  }
	  .bomb {
	    background: url("../images/bomb.png") center center no-repeat;
	    background-size: 200px 200px;
	  }
	  .boom {
	    background: url("../images/explode.png") center center no-repeat;
	    background-size: 200px 200px;
	  }
	  .hidden {
	    bottom: -200px;
	  }
	  .hole {
	    width: 200px;
	    height: 150px;
	    position: absolute;
	    bottom: 0;
	    background: url("../images/mole-hole.png") center center no-repeat;
	    background-size: 200px 150px;
	  }
	  .hole-front {
	    width: 200px;
	    height: 30px;
	    position: absolute;
	    bottom: 0;
	    background: url("../images/mole-hole-front.png") center center no-repeat;
	    background-size: 200px 30px;
	  }
	</style>
<body>
	<div>
	  
	  <span id="timer">8</span>초&nbsp; <span id="score">0</span>점
	  <button id="start">시작</button>
	  <button class="btn btn-dark" onclick="location.href='/index.jsp'">홈페이지로..</button>
	</div>
    <div id="game">
      <div class="row">
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
      </div>
      <div class="row">
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
      </div>
      <div class="row">
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
        <div class="cell">
          <div class="hole"></div>
          <div class="gopher hidden"></div>
          <div class="bomb hidden"></div>
          <div class="hole-front"></div>
        </div>
      </div>
    </div>
    
</body>
</html>