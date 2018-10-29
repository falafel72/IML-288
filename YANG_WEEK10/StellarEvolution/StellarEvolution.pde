ArrayList<Star> stars = new ArrayList<Star>();

void setup() {
  size(1280, 720);
  noStroke();
  fill(255);
  for (int i = 0; i < 200; i++) {
    stars.add(new Star());
  }
}

void draw() {
  background(0);
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).evolve();
    stars.get(i).display();
    if (stars.get(i).getDiam() > 20.0) {
      stars.remove(i);
      i--;
    }
    if (random(1) < 0.0001) {
      stars.add(new Star());
      println("add");
    }
  }
}
