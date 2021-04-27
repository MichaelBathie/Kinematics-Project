class Pong {
  Chain enemy;
  PVector ball;
  PVector player;

  final int paddleWidth = 50;
  final int paddleHeight = 150;

  int ballVelocityX = 4;
  int ballVelocityY = 2;
  final int ballD = 40;

  Pong(Chain enemy) {
    player = new PVector(100 - paddleWidth, height/2 - paddleHeight);
    ball = new PVector(width/2, height/2);
    this.enemy = enemy;
  }

  //creates all objects for the game
  void play() {
    makePlayer();
    makeBall();
    makeOpponent();
    adjustEndEffector();
  }

  void makePlayer() {
    fill(0,0,0);
    rect(player.x, player.y, paddleWidth, paddleHeight);
  }

  void makeBall() {
    collision();
    ball.x += ballVelocityX;
    ball.y += ballVelocityY;
    stroke(1,0,0);
    fill(1,0,0);
    circle(ball.x, ball.y, ballD);
  }

  void makeOpponent() {
    enemy.fabrik();
    stroke(0,0,0);
    fill(0,0,0);
    rect(enemy.forward[enemy.forward.length-1].x - paddleWidth/2, enemy.forward[enemy.forward.length-1].y - paddleHeight/2, paddleWidth, paddleHeight);
  }

  //we must change the position of the endeffect for the opponent as the pong ball moves around
  void adjustEndEffector() {
    enemy.endPoint.point.y = ball.y;
  }

  //simple collisions checks
  void collision() {
    if(ball.x + ballD/2 + ballVelocityX > width) {
      ballVelocityX = -ballVelocityX;
    }
    else if(ball.x - ballD/2 + ballVelocityX < 0) {
      ballVelocityX = -ballVelocityX;
    }
    if(ball.y + ballD/2 + ballVelocityY > height) {
      ballVelocityY = -ballVelocityY;
    }
    else if(ball.y - ballD/2 + ballVelocityY < 0) {
      ballVelocityY = -ballVelocityY;
    }

    //hit paddle side
    if(ball.x + ballD/2 >= player.x && ball.x - ballD/2 <= player.x + paddleWidth && ball.y >= player.y && ball.y <= player.y + paddleHeight) {
      ballVelocityX = -ballVelocityX;
    } else if (ball.x + ballD/2 >= enemy.forward[enemy.forward.length-1].x - paddleWidth/2 && ball.x - ballD/2 <= enemy.forward[enemy.forward.length-1].x + paddleWidth/2 && ball.y >= enemy.forward[enemy.forward.length-1].y - paddleHeight/2 && ball.y <= enemy.forward[enemy.forward.length-1].y + paddleHeight/2) {
      ballVelocityX = -ballVelocityX;
    }

    //hit paddle top
    if(((ball.x - ballD/2 <= player.x + paddleWidth && ball.x - ballD/2 >= player.x) || (ball.x + ballD/2 <= player.x + paddleWidth && ball.x + ballD/2 >= player.x)) && ((ball.y + ballD/2 >= player.y && ball.y - ballD/2 <= player.y) || (ball.y - ballD/2 <= player.y + paddleHeight && ball.y + ballD/2 >= player.y + paddleHeight))) {
      ballVelocityY = -ballVelocityY;
    }

    //I dont need to check top for opponent because they always hit it right in the middle as it's just IK. They basically can't miss

  }

  boolean checkBounds() {
    boolean inBound = false;

    if(mouseX >= 0 && mouseX <= width) {
      if(mouseY >= player.y && mouseY <= player.y + paddleHeight) {
        inBound = true;
      }
    }
    return inBound;
  }
}