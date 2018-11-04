class Particle {
  boolean gravity_on = false;
  static final float grav = 0.1;
  
  static final float vel_lower = 0.0;
  static final float vel_upper = 5.0;
  
  PVector pos;
  PVector vel;
  float size;
  
  PVector[] trail = new PVector[10];
  
  color c;
  float alpha;
  float fade_rate = 2.0;
  
  Particle(float x, float y, float star_size, color c, float alpha) {
    pos = new PVector(x, y);
    vel = new PVector(random(vel_lower, vel_upper), random(vel_lower, vel_upper));
    // Determine direction of velocity
    if (random(1) < 0.5) vel.x *= -1;
    if (random(1) < 0.5) vel.y *= -1;
    size = random(vel_lower, vel_upper);
    for (int i = 0; i < trail.length; i++) {
      trail[i] = new PVector(0, 0);
    }
    // Set fade_rate according to star_size
    fade_rate = star_size/10;
    this.c = c;
    this.alpha = alpha;
  }
  
  void update() {
    for (int i = trail.length - 1; i > 0; i--) {
      trail[i] = new PVector(trail[i - 1].x, trail[i - 1].y);
    }
    pos.add(vel);
    if (gravity_on) vel.add(0, grav);
    trail[0] = new PVector(pos.x, pos.y);
    // Fade particle
    if (alpha > 0) {
      alpha -= size*fade_rate;
    } else {
      alpha = 0;
    }
  }
  
  void display() {
    // Draw head
    ellipse(pos.x, pos.y, size, size);
    // Draw trail
    for (int i = 0; i < trail.length; i++) {
      float fraction = i/float(trail.length);
      fill(c, alpha - fraction * alpha);
      ellipse(trail[i].x, trail[i].y, size, size);
    }
  }
  
  float getAlpha() {
    return alpha;
  }
}
