class Disc {
  float x, y;
  float orig_diam;
  float diam;
  float phase;
  float rot_speed;
  int segments;
  color[] disc_colors;
  
  Disc() {
    x = random(width);
    y = random(height);
    orig_diam = random(50, 100);
    diam = orig_diam;
    rot_speed = random(0.0001, 0.001);
    phase = random(0, TWO_PI);
    segments = int(random(60, 220));
    disc_colors = new color[segments];
    for (int i = 0; i < disc_colors.length; i++) {
      disc_colors[i] = colors[int(random(colors.length))];
    }
  }
  
  void update() {
    diam = orig_diam + abs(200*sin(phase + millis() * 0.001));
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(millis() * rot_speed);
    for (int i = 0; i < segments; i++) {
      pushMatrix();
      float theta = i * TWO_PI/float(segments);
      rotate(theta);
      stroke(disc_colors[i]);
      line(0, 0, 0, diam);
      popMatrix();
    }
    popMatrix();
  }
}
