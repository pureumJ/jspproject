/**
 * 
 */
const $timer = document.querySelector("#timer");
const $score = document.querySelector("#score");
const $game = document.querySelector("#game");
const $start = document.querySelector("#start");
const $$cells = document.querySelectorAll(".cell");
 
let started = false;
let score = 0;
let time = 60;
 
$start.addEventListener("click", () => {
  if (started) return; // 이미 시작했으면 무시
  started = true;
  console.log("시작");
  const timerId = setInterval(() => {
    time = (time * 10 - 1) / 10; // 60초에서 점점 줄어든다.
    $timer.textContent = time;
    if (time === 0) {
      //1분이 지나면 게임이 끝난다.
      clearInterval(timerId); //시간(초) 업데이트 되는부분 해제
      clearInterval(tickId); //두더지와 폭탄 이미지 보여주는 부분 해제
      setTimeout(() => {
        alert(`게임 오버! 점수는${score}점`);
      }, 50);
    }
  }, 100);
  const tickId = setInterval(tick, 1000);
  tick();
});
 
const holes = [0, 0, 0, 0, 0, 0, 0, 0, 0];
 
//두더지와 폭탄, 빈칸의 비율 설정 : 두더지 30%, 폭탄 20%, 빈칸 50%
let gopherPercent = 0.3; //0 ~ 0.3까지
let bombPercent = 0.5; //0.3 ~ 0.5까지
function tick() {
  holes.forEach((hole, index) => {
    if (hole) return; // 무언가 일어나고 있으면 return
    const randomValue = Math.random();
    if (randomValue < gopherPercent) {
      const $gopher = $$cells[index].querySelector(".gopher");
      holes[index] = setTimeout(() => {
        // 1초 뒤에 사라짐
        $gopher.classList.add("hidden");
        holes[index] = 0;
      }, 1000);
      $gopher.classList.remove("hidden"); //두더지 보여줌
    } else if (randomValue < bombPercent) {
      const $bomb = $$cells[index].querySelector(".bomb");
      holes[index] = setTimeout(() => {
        // 1초 뒤에 사라짐
        $bomb.classList.add("hidden");
        holes[index] = 0;
      }, 1000);
 
      $bomb.classList.remove("hidden"); //폭탄 보여줌
    }
  });
}
 
//두더지와 폭탄을 클릭 이벤트 설정
$$cells.forEach(($cell, index) => {
  $cell.querySelector(".gopher").addEventListener("click", (event) => {
    if (!event.target.classList.contains("dead")) {
      // 두더지 클릭 -> 점수 + 1
      score += 1;
      $score.textContent = score;
    }
    event.target.classList.add("dead"); //울고 있는 두더지 모양 보여짐
    event.target.classList.add("hidden"); // 두더지 숨겨짐
    //clearTimeout(holes[index]); // 1초마다 두더지 내려가는 부분 제거
    setTimeout(() => {
      holes[index] = 0;
      event.target.classList.remove("dead"); // 1초 후 울고 있는 두더지 모양 제거됨
    }, 1000);
  });
  $cell.querySelector(".bomb").addEventListener("click", (event) => {
    event.target.classList.add("boom");
    event.target.classList.add("hidden");
    // clearTimeout(holes[index]); // 기존 내려가는 타이머 제거
    setTimeout(() => {
      holes[index] = 0;
      event.target.classList.remove("boom");
    }, 1000);
  });
});