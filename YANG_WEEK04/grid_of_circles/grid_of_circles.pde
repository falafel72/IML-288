size(1280, 720);
int diameter = 20;
int spacing = 20;
background(255);
noStroke();
for (int x = diameter/2; x < width; x += spacing) {
  for (int y = diameter/2; y < height; y += spacing) {
    fill(255, y*0.3, x*0.3);
    ellipse(x, y, diameter, diameter);
  }
}
