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
    if (h < height/2) {
      h += 10;
    }
  }

  public void makeShorter() {
    if (h > 10) {
      h -= 10;
    }
  }

  public void makeQuicker() {
    if (shift < 160) {
      shift += 10;
    }
  }

  public void makeSlower() {
    if (shift > 10) {
      shift -= 10;
    }
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
