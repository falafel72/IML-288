float x, y, petal_w, petal_h, radius;
int num_petals;
color base_c;
color[] colors = new color[3];

void setup() {
  size(1280, 720);
  colorMode(HSB, 360, 100, 100, 100);
  background(66, 4, 98.4);
  colors[0] = color(354.4, 55.6, 91, 95); // soft pink red
  colors[1] = color(9.2, 52, 98.8, 95); // soft salmon red
  colors[2] = color(48.7, 62.6, 99.6, 95); // soft yellow
  stroke(66, 4, 98.4, 20);
}

void draw() {
  // set random radius
  x = random(width);
  y = random(height);
  // set random radius
  radius = random(10, 30);
  // set petal width to random value thinner than radius
  petal_w = random(radius-5, radius-3);
  // set petal height to random value longer than radius
  petal_h = random(radius+5, radius+15);
  // set origin to center of flower
  translate(x, y);
  // pick random color from list of given colors
  base_c = colors[int(random(colors.length))];
  // pick random number of petals
  num_petals = int(random(6, 12));
  for (int i = 0; i < num_petals; i++) {
    // create variation on base color
    fill(color(hue(base_c), saturation(base_c) + random(-10, 10), brightness(base_c), alpha(base_c)));
    // draw petal by creating ellipse at half petal height above center
    ellipse(0, petal_h/2, petal_w, petal_h);
    // rotate to draw other petals
    rotate(TWO_PI/num_petals);
  }
  // draw white center
  fill(360, 0, 100);
  ellipse(0, 0, radius, radius);
}
