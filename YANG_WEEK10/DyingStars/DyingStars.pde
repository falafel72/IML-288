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
  //filter(BLUR, 5);
  background(0);
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).die();
    if (stars.get(i).getAlpha() <= 0) {
      stars.remove(i);
      i--;
      //stars.add(new Star(random(width), random(height),
      //  random(diam_lower, diam_upper), random(255)));
    }
  }
}
