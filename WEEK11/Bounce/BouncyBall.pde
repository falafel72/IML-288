class BouncyBall {  
  float x, y;
  float x_speed, y_speed;
  float diam;
  color c;
  
  int len = 10;
  float[] trail_x = new float[len];
  float[] trail_y = new float[len];
  
  BouncyBall() {
    x = random(width);
    y = random(height);
    x_speed = random(2.0, 10.0);
    y_speed = random(2.0, 10.0);
    diam = random(5.0, 10.0);
    c = color(random(255));
  }
  
  void update() {
    x += x_speed;
    y += y_speed;
    
    if (x <= 0 + diam/2) {
      x = diam/2;
      x_speed *= -1.0;
    } else if (x >= width - diam/2) {
      x = width - diam/2;
      x_speed *= -1.0;
    }
    if (y <= 0 + diam/2) {
      y = diam/2;
      y_speed *= -1.0;
    } else if (y >= height - diam/2) {
      y = height - diam/2;
      y_speed *= -1.0;
    }
    
    for (int i = trail_x.length - 1; i > 0; i--) {
      trail_x[i] = trail_x[i - 1];
      trail_y[i] = trail_y[i - 1];
    }
    trail_x[0] = x;
    trail_y[0] = y;
  }
  
  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, diam, diam);
    for (int i = 0; i < trail_x.length; i++) {
      fill(c, 255 - i/float(trail_x.length) * 255);
      ellipse(trail_x[i], trail_y[i], diam, diam);
    }
  }
}
