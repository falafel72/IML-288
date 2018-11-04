class Particle {
  PVector loc;
  PVector vel;
  float size;
  
  Particle(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(random(2.0, 5.0), random(2.0, 5.0));
    if (random(1) < 0.5) vel.x *= -1;
    if (random(1) < 0.5) vel.y *= -1;
    size = random(2.0, 5.0);
  }
  
  void update() {
    loc.add(vel);
  }
  
  void display() {
    ellipse(loc.x, loc.y, size, size);
  }
}
