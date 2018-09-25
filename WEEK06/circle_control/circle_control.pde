float x, y, diameter, distance;

void setup() {
  size(720, 720);
  x = width/2;
  y = height/2;
}

void draw() {
  background(255);
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
  //rect(x-100, y-100, 200, 200);
  ellipse(x, y, diameter, diameter);
}

void keyPressed() {
  if (keyCode == UP) {
    y -= 10;
  }
  if (keyCode == DOWN) {
    y += 10;
  }
  if (keyCode == RIGHT) {
    x += 10;
  }
  if (keyCode == LEFT) {
    x -= 10;
  }
}
