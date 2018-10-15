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
  background(0);
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
      abs(y - paddle1.getY()) < paddle1.getHeight()/2) {
      x_speed = -x_speed;
    } else if (x >= paddle2.getX() - diam/2 &&
      x < width &&
      abs(y - paddle2.getY()) < paddle2.getHeight()/2) {
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

  public float getDiam() {
    return diam;
  }
}

class Paddle {
  float x, y;
  float w = 10.0;
  float h = 100.0;
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
    rect(x, y, w, h);
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

  public void makeLonger() {
    h += 10;
  }

  public void makeShorter() {
    h -= 10;
  }

  public void makeQuicker() {
    shift += 10;
  }

  public void makeSlower() {
    shift -= 10;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public float getWidth() {
    return w;
  }

  public float getHeight() {
    return h;
  }

  public int getScore() {
    return score;
  }
}

class PowerUp {
  PImage icon_sheet;
  PImage[][] icons = new PImage[4][2];
  PImage lengthen1, lengthen2;
  PImage shorten1, shorten2;
  PImage accel1, accel2;
  PImage decel1, decel2;
  // TO-DO: star powerups that paddles can collect for points
  //PImage star, star3, star2, star1;
  int icon_w = 50;

  float x, y;
  // Types: lengthen, shorten, accel, decel, star
  int type;
  int player;

  PowerUp() {
    icon_sheet = loadImage("icon_sheet.png");
    icons[0][0] = icon_sheet.get(0, 0, icon_w, icon_w);
    icons[0][1] = icon_sheet.get(icon_w, 0, icon_w, icon_w);
    icons[1][0] = icon_sheet.get(icon_w*2, 0, icon_w, icon_w);
    icons[1][1] = icon_sheet.get(icon_w*3, 0, icon_w, icon_w);
    icons[2][0] = icon_sheet.get(0, icon_w, icon_w, icon_w);
    icons[2][1] = icon_sheet.get(icon_w, icon_w, icon_w, icon_w);
    icons[3][0] = icon_sheet.get(icon_w*2, icon_w, icon_w, icon_w);
    icons[3][1] = icon_sheet.get(icon_w*3, icon_w, icon_w, icon_w);
  }

  public void newPowerUp() {
    type = int(random(4));
    player = int(random(2));
    x = random(40.0, width - 40.0);
    y = random(height);
    powerup_exists = true;
  }

  public void display() {
    image(icons[type][player], x, y);
  }

  public void checkContact() {
    if (ball.getX() > x - icon_w/2 - 15 && ball.getX() < x + icon_w/2 + 15 &&
      ball.getY() > y - icon_w/2 - 15 && ball.getY() < y + icon_w/2 + 15) {
      println("contact");
      powerup_exists = false;
      if (type == 0 && player == 0) {
        paddle1.makeLonger();
      } else if (type == 0 && player == 1) {
        paddle2.makeLonger();
      } else if (type == 1 && player == 0) {
        paddle1.makeShorter();
      } else if (type == 1 && player == 1) {
        paddle2.makeShorter();
      } else if (type == 2 && player == 0) {
        paddle1.makeQuicker();
      } else if (type == 2 && player == 1) {
        paddle2.makeQuicker();
      } else if (type == 3 && player == 0) {
        paddle1.makeSlower();
      } else if (type == 3 && player == 1) {
        paddle2.makeSlower();
      }
    }
  }
}
