int[] x = new int[60];
int[] y = new int[60];
float diam;

void setup() {
  size(1280, 720);
}

void draw() {
  background(0);
  // update array positions
  for (int i = x.length - 1; i > 0; i--) {
    x[i] = x[i - 1];
    y[i] = y[i - 1];
  }
  x[0] = mouseX;
  y[0] = mouseY;
  // draw the array positions;
  for (int i = 0; i < x.length; i++) {
    noStroke();
    fill(255, 255 - i/float(x.length) * 255);
    diam = 50.0 - i/float(x.length) * 50.0;
    ellipse(x[i], y[i], diam, diam);
    stroke(255, 255 - i/float(x.length) * 255);
    line(width/2, height/2, x[i], y[i]);
  }
}
