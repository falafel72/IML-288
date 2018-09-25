float x, y, diameter, distance;

void setup() {
  size(720, 720);
}

void draw() {
  x = width/2;
  y = height/2;
  diameter = 300;
  distance = dist(mouseX, mouseY, x, y);
  fill(255);
  if (distance < diameter/2) {
    if (mousePressed) {
      fill(0, 0, 255);
    } else {
      fill(255, 0, 0);
    }
  }
  rect(x-100, y-100, 200, 200);
  //ellipse(x, y, diameter, diameter);
}
