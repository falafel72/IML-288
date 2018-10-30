float a = 200.0; // amplitude
float b = 0.02; // period = TWO_PI/b
float c; // vertical shift
float d; // horizontal shift
float x_step = 0.2;
float x_speed = 0.1;
float weight = 5.0;

float x_padding = 200.0;
float y_padding = 100.0;

color green = color(26, 122, 28);
color blue = color(43, 137, 186);
color red = color(235, 50, 58);

void setup() {
  size(1280, 720, P3D);
  ortho();
  rectMode(CENTER);
  c = float(height)/2.0;
}

void draw() {
  background(255);
  drawAxes();
  noStroke();
  d = x_speed * millis();
  drawXGraph();
  drawYGraph();
}

void drawAxes() {
  // x
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateY(-radians(45));
  drawArrowLine(-width/2+x_padding, 0, width/2-x_padding, 0);
  noStroke();
  fill(red(red), green(red), blue(red), 100);
  rect(0, 0, 100, 100);
  popMatrix();
  // y
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateY(radians(45));
  drawArrowLine(0, -height/2+y_padding, 0, height/2-y_padding);
  noStroke();
  fill(red(blue), green(blue), blue(blue), 100);
  rect(0, 0, 100, 100);
  popMatrix();
  // z
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateZ(radians(45));
  drawArrowLine(-width/2+x_padding, 0, width/2-x_padding, 0);
  noStroke();
  fill(red(green), green(green), blue(green), 100);
  rect(0, 0, 100, 100);
  popMatrix();
}

// antiplastik on https://processing.org/discourse/beta/num_1219607845.html
void drawArrowLine(float x1, float y1, float x2, float y2) {
  noFill();
  stroke(0);
  strokeWeight(2);
  strokeCap(PROJECT);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1 - x2, y2 - y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}

void drawXGraph() {
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateZ(radians(45));
  fill(green);
  for (float x = -width/2; x < width/2; x += x_step) {
    pushMatrix();
    translate(x, a*sin(b*(x-d)), 0);
    //ellipse(x, a*sin(b*(x-d))+c, weight, weight);
    ellipse(0, 0, weight, weight);
    popMatrix();
  }
  popMatrix();
}

void drawYGraph() {
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(radians(35.264));
  rotateY(radians(45));
  fill(blue);
  for (float x = -width/2; x < width/2; x += x_step) {
    pushMatrix();
    translate(x, a*sin(b*(x-d)), 0);
    //ellipse(x, a*sin(b*(x-d))+c, weight, weight);
    ellipse(0, 0, weight, weight);
    popMatrix();
  }
  popMatrix();
}
