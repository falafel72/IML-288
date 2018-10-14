float paddle_w = 10.0;
float paddle_h = 100.0;
Paddle paddle1;
Paddle paddle2;

Ball ball;

PFont font;

void setup() {
  size(1280, 720);
  rectMode(CENTER);
  
  font = createFont("Verdana", 40);
  textFont(font);

  paddle1 = new Paddle(1);
  paddle2 = new Paddle(2);

  ball = new Ball();
}

void draw() {
  background(0);
  ball.update();
  paddle1.drawPaddle();
  paddle2.drawPaddle();
  updateScore();
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

class Ball {
  float x, y;
  float x_speed = 4.0;
  float y_speed = 6.0;
  float diam = 40.0;

  Ball() {
    x = width/2;
    y = height/2;
    update();
  }

  public void update() {
    ellipse(x, y, diam, diam);
    x += x_speed;
    y += y_speed;
    // y
    if (y < diam/2) {
      y = diam/2;
      y_speed = -y_speed;
    } else if (y > height - diam/2) {
      y = height - diam/2;
      y_speed = -y_speed;
    }
    // x
    if (x <= paddle1.getX() + diam/2 &&
      x > 0 &&
      abs(y - paddle1.getY()) < paddle_h/2) {
      x_speed = -x_speed;
    } else if (x >= paddle2.getX() - diam/2 &&
      x < width &&
      abs(y - paddle2.getY()) < paddle_h/2) {
      x_speed = -x_speed;
    } else if (x < -diam/2) {
      paddle2.increaseScore();
      x = width/2;
      y = height/2;
    } else if (x > width + diam/2) {
      paddle1.increaseScore();
      x = width/2;
      y = height/2;
    }
  }

  public void resetWithRandom() {
    x = width/2;
    y = height/2;
    x_speed = random(4.0, 10.0);
    y_speed = random(4.0, 10.0);
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
}

class Paddle {
  float x, y;
  float shift = 40.0;

  int player;
  int score;

  Paddle(int player) {
    this.player = player;
    if (player == 1) {
      x = 40.0;
    } else if (player == 2) {
      x = width - 40.0;
    }
    y = height/2;
    drawPaddle();
  }

  public void drawPaddle() {
    fill(255);
    rect(x, y, paddle_w, paddle_h);
  }

  public void updatePosition() {
    if (key == 'q' || key == 'p') {
      y -= shift;
    } else if (key == 'a' || key == 'l') {
      y += shift;
    }
  }

  public void increaseScore() {
    score++;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public int getScore() {
    return score;
  }
}
