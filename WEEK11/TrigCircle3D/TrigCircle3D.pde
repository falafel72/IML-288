float a = 200.0; // amplitude
float b = 0.0005; // period = TWO_PI/b
float c; // vertical shift
float d; // horizontal shift
float x_step = 0.2;
float x_speed = 0.1;
float weight = 10.0;

float x_padding = 300.0;
float y_padding = 100.0;

color green = color(26, 122, 28);
color blue = color(43, 137, 186);
color red = color(235, 50, 58);

boolean show_grid = false;

float x;
float y;

void setup() {
  size(1280, 720, P3D);
  noStroke();
}

void draw() {
  background(255);
  x = a*cos(b*millis());
  y = a*cos(b*millis() - PI/2);
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(-radians(35.264));
  rotateY(radians(45));
  if (show_grid) {
    drawGrid();
  }
  // circle
  drawCircle();
  // x
  drawX();
  // y
  drawY();
  // round
  drawResult();
  // match
  drawMatch();
  popMatrix();
}

void drawGrid() {
  float grid_size = 20.0;
  strokeWeight(1);
  stroke(0);
  noFill();
  for (float i = -width/2; i < width/2; i += grid_size) {
    line(i, -height/2, i, height/2);
  }
  for (float i = -height/2; i < height/2; i += grid_size) {
    line(-width/2, i, width/2, i);
  }
  box(a);
}

void drawCircle() {
  strokeWeight(1);
  stroke(red(red), green(red), blue(red), 100);
  fill(red(red), green(red), blue(red), 100);
  ellipse(0, 0, a*2, a*2);
}

void drawX() {
  strokeWeight(1);
  stroke(red(green), green(green), blue(green), 100);
  line(0, 0, x, 0);
  noStroke();
  fill(green);
  pushMatrix();
  translate(x, 0, 0);
  ellipse(0, 0, weight, weight);
  popMatrix();
}

void drawY() {
  strokeWeight(1);
  stroke(red(blue), green(blue), blue(blue), 100);
  line(x, 0, x, y);
  noStroke();
  fill(blue);
  pushMatrix();
  translate(0, y, 0);
  ellipse(0, 0, weight, weight);
  popMatrix();
}

void drawResult() {
  fill(red(red), green(red), blue(red), 100);
  strokeWeight(1);
  stroke(red(red), green(red), blue(red), 100);
  line(0, 0, x, y);
  noStroke();
  ellipse(x, y, weight, weight);
}

void drawMatch() {
  fill(255, 100);
  strokeWeight(2);
  stroke(255, 100);
  if (abs(x) >= a - 0.1) {
    ellipse(x, 0, weight, weight);
  }
  if (abs(y) >= a - 0.1) {
    ellipse(0, y, weight, weight);
  }
}
