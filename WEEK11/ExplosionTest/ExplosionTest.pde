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
    if (particles.get(i).getAlpha() == 0) {
      particles.remove(i);
    }
  }
}

void mousePressed() {
  createExplosion();
}

void createExplosion() {
  for (int i = 0; i < int(random(10, 20)); i++) {
    particles.add(new Particle(float(mouseX), float(mouseY)));
  }
}
