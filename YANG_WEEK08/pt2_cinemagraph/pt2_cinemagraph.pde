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
  shape(teacup, width/2, 495);
  shape(teapot, 828, 295);
}
