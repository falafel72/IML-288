float x, y, w, h;

void setup() {
  size(720, 720);
}

void draw() {
  x = 100;
  y = 100;
  w = 300;
  h = 300;
  if (mouseX > x && mouseX < x + w &&
    mouseY > y && mouseY < y + h) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  rect(x, y, w, h);
}
