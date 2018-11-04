class Particle {
  boolean gravity_on = true;
  static final float grav = 0.1;
  
  PVector pos;
  PVector vel;
  float size;
  
  PVector[] trail = new PVector[10];
  
  int alpha;
  
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(2.0, 5.0), random(2.0, 5.0));
    if (random(1) < 0.5) vel.x *= -1;
    if (random(1) < 0.5) vel.y *= -1;
    size = random(2.0, 5.0);
    for (int i = 0; i < trail.length; i++) {
      trail[i] = new PVector(0, 0);
    }
    alpha = 255;
  }
  
  void update() {
    for (int i = trail.length - 1; i > 0; i--) {
      trail[i] = new PVector(trail[i - 1].x, trail[i - 1].y);
    }
    pos.add(vel);
    if (gravity_on) vel.add(0, grav);
    trail[0] = new PVector(pos.x, pos.y);
    if (alpha > 0) {
      alpha -= size*2;
    } else {
      alpha = 0;
    }
  }
  
  void display() {
    ellipse(pos.x, pos.y, size, size);
    for (int i = 0; i < trail.length; i++) {
      float fraction = i/float(trail.length);
      fill(0, alpha - fraction * alpha);
      ellipse(trail[i].x, trail[i].y, size, size);
    }
  }
  
  int getAlpha() {
    return alpha;
  }
}
