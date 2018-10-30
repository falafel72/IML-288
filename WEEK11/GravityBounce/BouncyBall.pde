class BouncyBall {
  static final float grav = 0.5;
  static final float dampen = 0.9;
  
  static final float speed_lower = 2.0;
  static final float speed_upper = 10.0;
  static final float diam_lower = 5.0;
  static final float diam_upper = 10.0;
  
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
    x_speed = random(speed_lower, speed_upper);
    y_speed = random(speed_lower, speed_upper);
    diam = random(diam_lower, diam_upper);
    c = color(random(255));
  }
  
  void update() {
    x += x_speed;
    
    y += y_speed;
    y_speed += grav;
    
    if (x <= 0 + diam/2) {
      x = diam/2;
      x_speed *= -dampen;
    } else if (x >= width - diam/2) {
      x = width - diam/2;
      x_speed *= -dampen;
    }
    if (y <= 0 + diam/2) {
      y = diam/2;
      y_speed *= -1.0;
    } else if (y >= height - diam/2) {
      y = height - diam/2;
      y_speed *= -dampen;
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
      float fraction = i/float(trail_x.length);
      fill(c, 255 - fraction * 255);
      ellipse(trail_x[i], trail_y[i], diam, diam);
    }
  }
}
