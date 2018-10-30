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
    if (y < diam/2) {
      y = diam/2;
      y_speed = -y_speed;
    } else if (y > height - diam/2) {
      y = height - diam/2;
      y_speed = -y_speed;
    }
    if (x <= paddle1.getX() + paddle1.getWidth()/2 + diam/2 &&
      abs(y - paddle1.getY()) < paddle1.getHeight()/2) {
      x = paddle1.getX() + paddle1.getWidth()/2 + diam/2;
      x_speed = -x_speed;
    } else if (x >= paddle2.getX() - paddle2.getWidth()/2 - diam/2 &&
      abs(y - paddle2.getY()) < paddle2.getHeight()/2) {
      x = paddle2.getX() - paddle2.getWidth()/2 - diam/2;
      x_speed = -x_speed;
    } else if (x < -diam/2) {
      paddle2.increaseScore();
      resetWithRandom();
    } else if (x > width + diam/2) {
      paddle1.increaseScore();
      resetWithRandom();
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
