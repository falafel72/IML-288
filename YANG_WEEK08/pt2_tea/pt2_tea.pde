// Vector files by Katemangostar: freepik.com/free-vector/drinks-icon-set_1488563.htm

PShape teacup, teapot;

float teacup_x = 640;
float teacup_y = 495;
float teapot_x = 750;
float teapot_y = 250;

void setup() {
  size(1280, 720);
  shapeMode(CENTER);
  strokeWeight(10);
  stroke(#963A26);
  teacup = loadShape("teacup.svg");
  teapot = loadShape("teapot.svg");
}

void draw() {
  background(#EFB9C0);
  // Tea
  for (int i = 310; i < teacup_y; i++) {
    ellipse(teacup_x + 10 * cos(0.1 * i + 0.001 * millis()), i, 5, 5);
  }
  // Teacup
  shape(teacup, teacup_x, teacup_y);
  // Teapot
  pushMatrix();
  translate(teapot_x, teapot_y);
  rotate(0.04 * sin(0.001 * millis()));
  shape(teapot, 0, 0);
  popMatrix();
}
