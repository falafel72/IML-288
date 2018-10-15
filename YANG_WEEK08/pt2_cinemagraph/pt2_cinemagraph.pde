// Vector files by Katemangostar: freepik.com/free-vector/drinks-icon-set_1488563.htm

PShape teacup, teapot;

void setup() {
  size(1280, 720);
  shapeMode(CENTER);
  teacup = loadShape("teacup.svg");
  teapot = loadShape("teapot.svg");
}

void draw() {
  background(#EFB9C0);
  // Teacup
  shape(teacup, width/2, 495);
  // Teapot
  pushMatrix();
  translate(828, 295);
  println(millis());
  rotate(0.1 * sin(0.001 * millis()));
  shape(teapot, 0, 0);
  popMatrix();
}
