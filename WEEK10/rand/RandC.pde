class RandC {
  float diam;
  float x, y;
  float x_speed, y_speed;
  float rot_speed = 0.001;
  color c;

  RandC() {
    diam = random(50, 100);
    x = random(width);
    y = random(height);
    x_speed = random(2.0, 10.0);
    x_speed = (random(1) < 0.5) ? x_speed*1.0 : x_speed*-1.0;
    y_speed = random(2.0, 10.0);
    y_speed = (random(1) < 0.5) ? y_speed*1.0 : y_speed*-1.0;
    c = colors[int(random(colors.length))];
  }

  void move() {
    x += x_speed;
    y += y_speed;
    if (x <= diam/2) {
      x = diam/2;
      x_speed *= -1;
    } else if (x >= width - diam/2) {
      x = width - diam/2;
      x_speed *= -1;
    }
    if (y <= diam/2) {
      y = diam/2;
      y_speed *= -1;
    } else if (y >= height - diam/2) {
      y = height - diam/2;
      y_speed *= -1;
    }
  }

  void display() {
    stroke(c);
    strokeWeight(10);
    //strokeWeight(10 * diam * 0.02);
    //ellipse(x, y, diam, diam);
    pushMatrix();
    translate(x, y);
    rotate(millis() * rot_speed);
    //arc(x, y, diam, diam, PI*0.125, TWO_PI*0.92);
    arc(0, 0, diam, diam, PI*0.125, TWO_PI*0.92);
    popMatrix();
  }
}
