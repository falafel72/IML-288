Paddle paddle1;
Paddle paddle2;

Ball ball;

PFont font;

PowerUp powerup;
boolean powerup_exists = false;

void setup() {
  size(1280, 720);
  rectMode(CENTER);

  font = createFont("Verdana", 40, true);
  textFont(font);

  powerup = new PowerUp();

  paddle1 = new Paddle(1);
  paddle2 = new Paddle(2);

  ball = new Ball();
}

void draw() {
  //background(0);
  background(#2C2B33);
  paddle1.drawPaddle();
  paddle2.drawPaddle();
  createPowerUp();
  ball.update();
  updateScore();
}

void createPowerUp() {
  if (powerup_exists == false) {
    if (random(1) < 0.05) {
      powerup.newPowerUp();
    }
  } else {
    powerup.display();
    powerup.checkContact();
  }
}

void updateScore() {
  text(paddle1.getScore(), width/2 - 200, 100);
  text(paddle2.getScore(), width/2 + 200, 100);
}

void keyPressed() {
  if (key == 'q' || key == 'a') {
    paddle1.updatePosition();
  } else if (key == 'p' || key == 'l') {
    paddle2.updatePosition();
  } else if (key == ' ') {
    ball.resetWithRandom();
  }
}
