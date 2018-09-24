size(720, 720);
background(0);
blendMode(SCREEN);
noStroke();
int box = 180;
float x, y, len;
for (int i = 0; i < 10; i++) {
  x = random((width - box)/2, height - (height - box)/2);
  y = random((width - box)/2, height - (height - box)/2);
  len = random(100);
  color[] colors = {color(255, 0, 0), color(255, 255, 0), color(0, 0, 255)};
  fill(colors[int(random(3))]);
  ellipse(x, y, len, len);
}
