PVector ballPos;
PVector player1Pos;
PVector player2Pos;
float moveSpeed = 3;
boolean gameOver;
PVector ballVel;
boolean gameWin;

int p1score;
int p2score;

void setup() {
  size(800, 600);
  frameRate(40);
  gameWin = false;
  gameOver = false;
  
  ballPos = new PVector(width/2, height/2);
  player1Pos = new PVector(15, height/2);
  player2Pos = new PVector(width-15, height/2);
  ballVel = new PVector(random(-5, 5), random(-5, 5));
}

void draw() {
  background(0);

  if (!gameOver) {
    drawBall();
    drawPaddles();
    ballUpdatePos();
    detectEdges();
    ballOut();
    checkForWin();
    batHit();
    scoreText();
    enemyBatMove();
  } else {
    endScreen();
  }
}

void drawBall() {
  fill(255);
  stroke(255);
  rect(ballPos.x, ballPos.y, 20, 20);
}

void drawPaddles() {
  fill(255);
  stroke(255);
  rectMode(CENTER);
  rect(player1Pos.x, player1Pos.y, 10, 140);
  rect(player2Pos.x, player2Pos.y, 10, 140);
}

void resetBall() {
  ballPos = new PVector(width/2, height/2);  
  ballVel = new PVector(random(-5, 5), random(-2.5, 2.5));
}

void ballOut() {
  if (ballPos.x > width) {
    p1score++;
    resetBall();
  } else if (ballPos.x < 0) {
    p2score++;
    resetBall();
  }
}

void checkForWin() {
  if (p1score >= 3) {
    gameOver = true;
    gameWin = true;
  } else if (p2score >= 3) {
    gameOver = true;
    gameWin = false;
  }
}

void endScreen() {
  if (gameWin) {

    textAlign(CENTER);

    fill(255);
    stroke(255);
    textSize(45);
    text("You Win!! Press any key to play again", width/2, height/2);
  } else {

    textAlign(CENTER);

    fill(255);
    stroke(255);
    textSize(45);
    text("You Lose :( Press any key to play again", width/2, height/2);
  }
}

void ballUpdatePos() {
  ballPos.add(ballVel);
}

void detectEdges() {
  if (ballPos.y > height-10 || ballPos.y < 10) {
    float b=  ballVel.y;

    if (b < 0) {
      b -= b*2;
    } else {
      b*=-1;
    }

    ballVel.y = b;
  }
}

void batHit() {
  if (withinCoords(player1Pos.x-10, player1Pos.y-70, player1Pos.x+10, player1Pos.y+70, ballPos) || withinCoords(player2Pos.x-10, player2Pos.y-70, player2Pos.x+10, player2Pos.y+70, ballPos)) {
    ballVel.rotate(radians(180));
    float mag = ballVel.mag();

    ballVel.setMag(mag+1);
  }
}

boolean withinCoords(float x, float y, float x1, float y1, PVector pos) {
  if (pos.x > x && pos.x < x1 && pos.y > y && pos.y < y1) {
    return true;
  }
  return false;
}

void keyPressed() {
  if (gameOver) {
    resetGame();
  } else {
    switch(key) {
    case 'w':
      //if (player1Pos.y < height - 70) {
        player1Pos.y -= 12;
      //}
      break;
    case 's':
      //if (player1Pos.y > 70) {
        player1Pos.y += 12;
      //}
      break;
    }
  }
}

void scoreText() {
  fill(255);
  stroke(255);

  textSize(35);
  text(p1score, 20, 30);
  text(p2score, width-30, 30);
}

void enemyBatMove() {
  if(player2Pos.y > ballPos.y) {
    player2Pos.y-=moveSpeed; 
  }
  else if(player2Pos.y < ballPos.y) {
    player2Pos.y+=moveSpeed;
  }
}

void resetGame() {
  gameWin = false;
  gameOver = false;
  
  ballPos = new PVector(width/2, height/2);
  player1Pos = new PVector(15, height/2);
  player2Pos = new PVector(width-15, height/2);
  ballVel = new PVector(random(-5, 5), random(-5, 5));
}
