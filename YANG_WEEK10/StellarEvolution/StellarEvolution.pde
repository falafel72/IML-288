ArrayList<Star> stars = new ArrayList<Star>();

int starting_pop = 200;
float explode_diam = 20.0;
float prob_new_star = 0.0001;

void setup() {
  size(1280, 720);
  noStroke();
  for (int i = 0; i < starting_pop; i++) {
    stars.add(new Star());
  }
}

void draw() {
  background(0);
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).evolve();
    stars.get(i).display();
    if (stars.get(i).getDiam() > explode_diam) {
      stars.remove(i);
      i--;
    }
    if (random(1) < prob_new_star) {
      stars.add(new Star());
    }
  }
}
