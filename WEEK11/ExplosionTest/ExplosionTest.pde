ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(1280, 720);
  noStroke();
  fill(0);
}

void draw() {
  background(255);
  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).update();
    particles.get(i).display();
  }
}

void mousePressed() {
  createExplosion();
}

void createExplosion() {
  for (int i = 0; i < 10; i++) {
    particles.add(new Particle(float(mouseX), float(mouseY)));
  }
}
