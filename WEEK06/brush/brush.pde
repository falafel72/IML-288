float x, y;
float px, py;
float targetX, targetY;
float easing = 0.1;
float strokewt;

void setup() {
  size(1280, 720);
}

void draw() {
  targetX = mouseX;
  x += (targetX - x) * easing;
  targetY = mouseY;
  y += (targetY - y) * easing;
  //strokewt = dist(pmouseX, pmouseY, mouseX, mouseY);
  strokewt = dist(px, py, x, y);
  if (strokewt < 5) {
    strokewt = 5;
  } else if (strokewt > 100) {
    strokewt = 100;
  }
  strokeWeight(strokewt);
  //stroke(255, 255-strokewt*2);
  if (mousePressed) {
    line(px, py, x, y);
  }
  px = x;
  py = y;
}
