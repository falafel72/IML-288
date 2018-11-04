// Insp: edmundoptics.de/resources/application-notes/optics/introduction-to-polarization

float a = 200.0; // amplitude
float b = 0.02; // period = TWO_PI/b
float c; // vertical shift
float d; // horizontal shift
float x_step = 0.2;
float x_speed = 0.001;
float weight = 5.0;

float x_padding = 300.0;
float y_padding = 100.0;
float depth = 600.0;

color green = color(26, 122, 28);
color blue = color(43, 137, 186);
color red = color(235, 50, 58);
int alpha = 50;

boolean show_grid = false;
float grid_size = 20.0;

float x;
float y;

void setup() {
  size(1280, 720, P3D);
  noStroke();
}

void draw() {
  background(255);
  x = a*cos(b*0 - x_speed*millis());
  y = a*sin(b*0 - x_speed*millis());
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(-radians(35.264));
  rotateY(radians(45));
  if (show_grid) {
    drawGrid();
    pushMatrix();
    translate(0, 0, -depth);
    drawGrid();
    popMatrix();
  }
  drawCircle();
  drawAxes();
  drawXGraph();
  drawYGraph();
  drawX();
  drawY();
  drawCombination();
  drawMatch();
  popMatrix();
}

void drawGrid() {
  strokeWeight(1);
  stroke(0, alpha);
  noFill();
  for (float i = -width/2 + x_padding; i < width/2 - x_padding; i += grid_size) {
    line(i, -height/2 + y_padding, i, height/2 - y_padding);
  }
  for (float i = -height/2 + y_padding; i < height/2 - y_padding; i += grid_size) {
    line(-width/2 + x_padding, i, width/2 - x_padding, i);
  }
  //box(a);
}

void drawCircle() {
  noFill();
  strokeWeight(1);
  stroke(red(red), green(red), blue(red), alpha);
  //fill(red(red), green(red), blue(red), alpha);
  ellipse(0, 0, a*2, a*2);
}

void drawAxes() {
  strokeWeight(1);
  // front
  stroke(green);
  drawArrowLine(-a, 0, a, 0);
  stroke(blue);
  drawArrowLine(0, -a, 0, a);
  // back
  pushMatrix();
  translate(0, 0, -depth);
  stroke(green);
  drawArrowLine(-a, 0, a, 0);
  stroke(blue);
  drawArrowLine(0, -a, 0, a);
  popMatrix();
  // z
  pushMatrix();
  // reset
  rotateY(-radians(45));
  rotateX(radians(35.264));
  // rotate
  rotateX(radians(54.58));
  rotateZ(radians(45));
  translate(-depth/2, 0, 0);
  stroke(0);
  drawArrowLine(-depth/2, 0, depth/2, 0);
  popMatrix();
}

// antiplastik on https://processing.org/discourse/beta/num_1219607845.html
void drawArrowLine(float x1, float y1, float x2, float y2) {
  //stroke(0);
  //strokeWeight(2);
  //strokeCap(PROJECT);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1 - x2, y2 - y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
}

void drawX() {
  strokeWeight(2);
  stroke(red(green), green(green), blue(green), alpha);
  line(0, 0, x, 0);
  line(0, y, x, y);
  noStroke();
  fill(green);
  ellipse(x, 0, weight, weight);
}

void drawXGraph() {
  noStroke();
  fill(green);
  for (float z = -depth; z < 0; z += x_step) {
    pushMatrix();
    translate(a * cos(b*z - x_speed*millis()), 0, z);
    ellipse(0, 0, weight, weight);
    popMatrix();
  }
}

void drawY() {
  strokeWeight(2);
  stroke(red(blue), green(blue), blue(blue), alpha);
  line(0, 0, 0, y);
  line(x, 0, x, y);
  noStroke();
  fill(blue);
  ellipse(0, y, weight, weight);
}

void drawYGraph() {
  noStroke();
  fill(blue);
  for (float z = -depth; z < 0; z += x_step) {
    pushMatrix();
    translate(0, a*sin(b*z - x_speed*millis()), z);
    ellipse(0, 0, weight, weight);
    popMatrix();
  }
}

void drawCombination() {
  fill(red);
  strokeWeight(2);
  stroke(red);
  line(0, 0, x, y);
  noStroke();
  ellipse(x, y, weight, weight);
}

void drawMatch() {
  fill(255, 255);
  strokeWeight(2);
  stroke(255, 255);
  if (abs(x) >= a - 0.1) {
    ellipse(x, 0, weight, weight);
  }
  if (abs(y) >= a - 0.1) {
    ellipse(0, y, weight, weight);
  }
}
