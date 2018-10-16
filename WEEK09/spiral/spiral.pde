float theta;
float a = 1.0;
float b = 0.001;
float x;
float y;
float diam;
float h;

void setup() {
  size(1280, 720);
  colorMode(HSB, 255);
  //stroke(0, 60);
}

void draw() {
  //background(255);
  theta = b*millis();
  diam = b*millis();
  x = a*cos(b*millis());
  y = a*sin(b*millis());
  //h = b*millis() % 255;
  h = map(y, -height/2, height/2, 0, 255);
  pushMatrix();
  translate(width/2, height/2);
  stroke(h, 255, 255, 160);
  line(0, 0, x, y);
  ellipse(x, y, diam, diam);
  popMatrix();
  a += 0.1;
}
