class Particle {
  boolean gravity_on = false;
  static final float grav = 0.1;
  
  static final float vel_lower = 0.0;
  static final float vel_upper = 5.0;
  
  PVector pos;
  PVector vel;
  float size;
  
  PVector[] trail = new PVector[10];
  
  float alpha;
  float fade_rate = 2.0;
  
  Particle(float x, float y, float star_size, float alpha) {
    pos = new PVector(x, y);
    vel = new PVector(random(vel_lower, vel_upper), random(vel_lower, vel_upper));
    if (random(1) < 0.5) vel.x *= -1;
    if (random(1) < 0.5) vel.y *= -1;
    size = random(vel_lower, vel_upper);
    for (int i = 0; i < trail.length; i++) {
      trail[i] = new PVector(0, 0);
    }
    fade_rate = star_size/10;
    this.alpha = alpha;
  }
  
  void update() {
    for (int i = trail.length - 1; i > 0; i--) {
      trail[i] = new PVector(trail[i - 1].x, trail[i - 1].y);
    }
    pos.add(vel);
    if (gravity_on) vel.add(0, grav);
    trail[0] = new PVector(pos.x, pos.y);
    if (alpha > 0) {
      alpha -= size*fade_rate;
    } else {
      alpha = 0;
    }
  }
  
  void display() {
    ellipse(pos.x, pos.y, size, size);
    for (int i = 0; i < trail.length; i++) {
      float fraction = i/float(trail.length);
      fill(255, alpha - fraction * alpha);
      ellipse(trail[i].x, trail[i].y, size, size);
    }
  }
  
  float getAlpha() {
    return alpha;
  }
}
