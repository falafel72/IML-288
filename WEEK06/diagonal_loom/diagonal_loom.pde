void setup() {
  size(1280, 720);
}

void draw() {
  noStroke();
  fill(220, 10);
  float r = map(mouseX, 0, width, 0, 255);
  float g = map(mouseY, 0, height, 0, 255);
  //float b = map(mouse
  rect(0, 0, width, height);
  //stroke(0, 100);
  stroke(r, g, 255);
  if (!(mouseX == 0 && mouseY == 0)) {
    line(0, 0, mouseX, mouseY);
    line(width, height, mouseX, mouseY);
  }
}
