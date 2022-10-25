var blockSize = 1;
var rows = 25;
var cols = 25;
var snakeunit = 'vh';
var board;
var context;

snake = {
  x: blockSize * 5,
  y: blockSize * 5,

  body: [],
  bodyelement: [],

  velocityX: 0,
  velocityY: 0,

  foodx: 0,
  foody: 0,

  diffucilty: 1,

  gameoverstate: false,
  score: 0,
  highscore: 0,
  footer: {},
  tabopen: '#snake-home',
  lasttabopen: null,

  canpress: true,
  firsttime: true,
  changeddirection: false,
};

$(function () {
  $('#snake-homebutton').fadeOut(0);
  $('#snake-playagain').fadeOut(0);
  $('#snake-instruction').fadeOut(0);

  window.addEventListener('message', function (event) {
    var v = event.data;

    if (v.app == 'snake' && v.task == 'load') {
      snake.loadranking(v.html);
    } else if (v.app == 'snake' && v.task == 'sethighscore') {
      snake.highscore = v.score;
    }
  });
});

snake.show = function () {
  ShowHomebar();
  $('#snake').css({
    'z-index': '2',
  });
  $('#snake').animate({
    left: '0%',
  });

  Main.openapp = 'snake';
};

var food = document.createElement('div');
var head = document.createElement('div');

let snakeinterval;

snake.start = function () {
  snake.footer.open('#snake-game');
  $('#snake-gameover').fadeOut(0);
  $('#snake-yourscore').fadeOut(0);
  $('#snake-highscore').fadeOut(0);
  $('#snake-playagain').fadeOut(0);

  if (snake.firsttime == true) {
    $('#snake-instruction').fadeIn(0);
    snake.firsttime = false;
  }
  board = document.getElementById('snake-canvas');

  snake.placefood();

  food = document.createElement('div');
  board.append(food);
  food.classList.add('food');

  head = document.createElement('div');
  board.append(head);
  head.classList.add('head');

  snake.x = blockSize * 5;
  (snake.y = blockSize * 5), (food.style.left = snake.foodx + snakeunit);
  food.style.top = snake.foody + snakeunit;

  document.addEventListener('keyup', snake.changedirection);
  snake.gameoverstate = false;
  snake.diffucilty = 1.25;

  snake.canpress = true;
  snakeinterval = setInterval(() => {
    snake.update();
  }, 1000 / (10 * snake.diffucilty));
};

snake.createbody = class {
  constructor(x, y) {
    this.visual = document.createElement('div');
    const visual = this.visual;

    this.left = x;
    this.top = y;

    $(visual).addClass('head');

    visual.style.left = this.left + snakeunit;
    visual.style.top = this.top + snakeunit;

    board.append(visual);
  }
};

snake.update = function () {
  console.log(snake.changeddirection);
  if (snake.gameoverstate) return;
  if (snake.changeddirection) return;
  if (
    snake.x < 0 ||
    snake.x > cols * blockSize ||
    snake.y < 0 ||
    snake.y > rows * blockSize
  ) {
    snake.gameover();
  }

  for (let index = 0; index < snake.body.length; index++) {
    const element = snake.body[index];

    if (snake.x == element.x && snake.y == element.y) {
      snake.gameover();
    }
  }

  if (snake.gameoverstate) return;

  food.style.left = snake.foodx + snakeunit;
  food.style.top = snake.foody + snakeunit;

  if (snake.x == snake.foodx && snake.y == snake.foody) {
    let snakebody = new snake.createbody(snake.foodx, snake.foody);

    snake.body.push({
      div: snakebody,
      x: snake.foodx,
      y: snake.foody,
    });

    snake.score += 1;
    $('#snake-score').html(snake.score);
    snake.placefood();
  }

  for (let index = snake.body.length - 1; index > 0; index--) {
    snake.body[index].x = snake.body[index - 1].x;
    snake.body[index].y = snake.body[index - 1].y;
  }

  if (snake.body.length) {
    snake.body[0].x = snake.x;
    snake.body[0].y = snake.y;
  }

  for (let index = 0; index < snake.body.length; index++) {
    const element = snake.body[index];
    let visual = element.div.visual;

    $(visual).css({
      left: element.x + snakeunit,
      top: element.y + snakeunit,
    });
  }

  snake.x += Math.floor(snake.velocityX * blockSize);
  snake.y += Math.floor(snake.velocityY * blockSize);

  // Game over

  $(head).css({
    left: snake.x + snakeunit,
    top: snake.y + snakeunit,
  });
  snake.changeddirection = false;
  console.log('set changeddirection to false');
  snake.canpress = true;
  // head.style.left = snake.x + snakeunit
  // head.style.top = snake.y + snakeunit
};

snake.changedirection = function (e) {
  if (snake.canpress == false) return;
  console.log('changedirection');
  let ok = false;
  if (e.code == 'ArrowUp' && snake.velocityY == 0) {
    snake.velocityX = 0;
    snake.velocityY = -1;
    ok = true;
  } else if (e.code == 'ArrowDown' && snake.velocityY == 0) {
    snake.velocityX = 0;
    snake.velocityY = 1;
    ok = true;
  } else if (e.code == 'ArrowRight' && snake.velocityX == 0) {
    snake.velocityX = 1;
    snake.velocityY = 0;
    ok = true;
  } else if (e.code == 'ArrowLeft' && snake.velocityX == 0) {
    snake.velocityX = -1;
    snake.velocityY = 0;
    ok = true;
  }
  if (ok) {
    console.log('ok');
    snake.canpress = false;

    snake.update();
    snake.changeddirection = true;
    setTimeout(() => {
      snake.changeddirection = false;
    }, 1000 / (10 * snake.diffucilty));
    $('#snake-instruction').fadeOut(0);
  }
};

snake.gameover = function () {
  snake.gameoverstate = true;
  snake.canpress = false;
  $('#snake-gameover').fadeIn(500);
  $('#snake-yourscore').fadeIn(500);
  $('#snake-highscore').fadeIn(500);
  $('#snake-homebutton').fadeIn(500);
  $('#snake-playagain').fadeIn(500);
  $('#snake-score').html('');

  $('#snake-yourscore').html('Score <br>  ' + snake.score);

  if (snake.score > snake.highscore) {
    snake.highscore = snake.score;
    sendData('snake:newhighscore', {
      score: snake.score,
    });
  }

  $('#snake-highscore').html('Highscore <br>  ' + snake.highscore);

  clearInterval(snakeinterval);

  $(head).remove();
  $(food).remove();

  for (let index = 0; index < snake.body.length; index++) {
    const element = snake.body[index];
    let visual = element.div.visual;

    $(visual).remove();
  }

  snake.body = [];

  snake.velocityX = 0;
  snake.velocityY = 0;

  snake.score = 0;
};

snake.placefood = function () {
  snake.foodx = Math.floor(Math.random() * cols) * blockSize;
  snake.foody = Math.floor(Math.random() * rows) * blockSize;
};

snake.footer.open = function (newopen) {
  if (newopen == snake.tabopen) return;

  setTimeout(function () {
    $(snake.tabopen).animate({
      'margin-left': '100%',
    });
    $(newopen).css({
      'margin-left': '0%',
      'margin-right': '100%',
    });
    setTimeout(function () {
      $(newopen).animate(
        {
          'margin-right': '0%',
        },
        500
      );
    }, 10);
    snake.lasttabopen = snake.tabopen;
    snake.tabopen = newopen;
  }, 10);
};

$(document).on('click', '#snake-home-start', function () {
  snake.start();
  $('#snake-homebutton').fadeIn(500);
});

$(document).on('click', '#snake-home-highscore', function () {
  snake.footer.open('#snake-highscoretab');
  $('#snake-homebutton').fadeIn(500);
});

$(document).on('click', '#snake-homebutton', function () {
  snake.gameover();
  snake.footer.open('#snake-home');
  $('#snake-homebutton').fadeOut(0);
  $('#snake-playagain').fadeOut(0);
  $('#snake-instruction').fadeOut(0);
});

$(document).on('click', '#snake-playagain', function () {
  $('#snake-playagain').fadeOut(0);
  snake.start();
});

snake.loadranking = function (html) {
  $('#snake-highscoretable').html(html);
};
