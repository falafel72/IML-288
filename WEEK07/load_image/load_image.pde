PImage img;

void setup() {
  size(1280, 720);
  imageMode(CENTER);
  img = loadImage("think.png");
}

void draw() {
  background(220);
  float size = 100 * sin(millis() * 0.001) + 150;
  pushMatrix();
  translate(mouseX, mouseY);
  rotate(millis() * 0.001);
  image(img, 0, 0, size, size);
  popMatrix();
}
