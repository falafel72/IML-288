size(720, 720);
float size;
rectMode(CENTER);
for (int x = 0; x < width; x += 50) {
  for (int y = 0; y < height; y += 50) {
    size = random(10, 50);
    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI));
    rect(0, 0, size, size);
    popMatrix();
  }
}
