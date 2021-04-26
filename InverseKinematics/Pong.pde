class Pong {
  Chain enemy;
  PVector ball;
  PVector player;

  final int paddleWidth = 50;
  final int paddleHeight = 150;

  int ballVelocityX = 6;
  int ballVelocityY = 4;
  final int ballD = 40;

  Pong(Chain enemy) {
    player = new PVector(100 - paddleWidth, height/2 - paddleHeight);
    ball = new PVector(width/2, height/2);
    this.enemy = enemy;
  }

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

  void adjustEndEffector() {
    enemy.endPoint.point.y = ball.y;
  }

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


    if(ball.x + ballD/2 >= player.x && ball.x - ballD/2 <= player.x + paddleWidth && ball.y >= player.y && ball.y <= player.y + paddleHeight) {
      ballVelocityX = -ballVelocityX;
    } else if (ball.x + ballD/2 >= enemy.forward[enemy.forward.length-1].x - paddleWidth/2 && ball.x - ballD/2 <= enemy.forward[enemy.forward.length-1].x + paddleWidth/2 && ball.y >= enemy.forward[enemy.forward.length-1].y - paddleHeight/2 && ball.y <= enemy.forward[enemy.forward.length-1].y + paddleHeight/2) {
      ballVelocityX = -ballVelocityX;
    }

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