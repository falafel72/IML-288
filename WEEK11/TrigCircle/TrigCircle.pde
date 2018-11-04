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

void setup() {
  size(1280, 720);
  noStroke();
}

void draw() {
  background(255);
  float x = a*cos(b*millis());
  float y = a*cos(b*millis() - PI/2);
  // circle
  pushMatrix();
  translate(width/2, height/2);
  strokeWeight(1);
  stroke(red(red), green(red), blue(red), 100);
  fill(red(red), green(red), blue(red), 100);
  ellipse(0, 0, a*2, a*2);
  popMatrix();
  // x
  pushMatrix();
  translate(width/2, height/2);
  stroke(red(green), green(green), blue(green), 100);
  line(0, 0, x, 0);
  noStroke();
  fill(green);
  pushMatrix();
  translate(x, 0);
  ellipse(0, 0, weight, weight);
  popMatrix();
  popMatrix();
  // y
  pushMatrix();
  translate(width/2, height/2);
  stroke(red(blue), green(blue), blue(blue), 100);
  line(x, 0, x, y);
  noStroke();
  fill(blue);
  pushMatrix();
  translate(0, y);
  ellipse(0, 0, weight, weight);
  popMatrix();
  popMatrix();
  // round
  pushMatrix();
  translate(width/2, height/2);
  fill(red(red), green(red), blue(red), 100);
  stroke(red(red), green(red), blue(red), 100);
  line(0, 0, x, y);
  noStroke();
  ellipse(x, y, weight, weight);
  popMatrix();
  // match
  pushMatrix();
  translate(width/2, height/2);
  //fill(255, 100);
  noFill();
  stroke(255, 100);
  strokeWeight(2);
  if (abs(x) >= a - 0.1) {
    ellipse(x, 0, weight, weight);
  }
  if (abs(y) >= a - 0.1) {
    ellipse(0, y, weight, weight);
  }
  popMatrix();
}
