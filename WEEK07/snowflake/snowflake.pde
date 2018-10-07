PShape flake;

void setup() {
  size(1280, 720);
  shapeMode(CENTER);
  flake = loadShape("flake.svg");
}

void draw() {
  background(220);
  pushMatrix();
  translate(width/2, height/2);
  for (float theta = 0; theta < TWO_PI; theta += PI / 3) {
    pushMatrix();
    rotate(theta);
    shape(flake, 0, -100);
    popMatrix();
  }
  popMatrix();
}
