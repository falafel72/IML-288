/****
A very generalised simulation of stellar evolution.
(Because I took the Astrophysics unit in IB Physics and it was amazing!)
****/

ArrayList<Star> stars = new ArrayList<Star>();

int starting_pop = 200;
float explode_diam = 20.0;
float prob_new_star = 0.0001;

void setup() {
  size(1280, 720);
  noStroke();
  // Add starting_pop number of stars
  for (int i = 0; i < starting_pop; i++) {
    stars.add(new Star());
  }
}

void draw() {
  background(0);
  for (int i = 0; i < stars.size(); i++) {
    // Evolve and show stars
    stars.get(i).evolve();
    stars.get(i).display();
    // If star larger than explode_diam, remove it
    if (stars.get(i).getDiam() > explode_diam && !stars.get(i).isExploding()) {
      stars.get(i).explode();
    }
    if (stars.get(i).isExploded()) {
      stars.remove(i);
    }
    // Occasionally add a new star
    if (random(1) < prob_new_star) {
      stars.add(new Star());
    }
  }
}
