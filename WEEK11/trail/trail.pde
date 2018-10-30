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
  for (int i = 1; i < x.length; i++) {
    noStroke();
    float fraction = i/float(x.length);
    //fill(255, 255 - fraction * 255);
    fill(255.0 - fraction * 255.0);
    diam = 10.0 - fraction * 10.0;
    //diam = 100.0 * fraction;
    //ellipse(x[i], y[i], diam, diam);
    //stroke(255, 255 - fraction * 255);
    stroke(255.0 - fraction * 255.0);
    //line(width/2, height/2, x[i], y[i]);
    float y_val = sin(2.0 * TWO_PI * fraction) * 100;
    line(x[i], y[i] - y_val, x[i], y[i]);
    line(x[i], y[i] + y_val, x[i], y[i]);
    ellipse(x[i], y[i] - y_val, diam, diam);
    ellipse(x[i], y[i] + y_val, diam, diam);
    //line(x[i - 1], y[i - 1], x[i], y[i]);
  }
}
