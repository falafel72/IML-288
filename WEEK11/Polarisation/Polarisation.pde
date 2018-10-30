float a = 200.0;
float b = 0.02;
float c;
float d;
float x_step = 0.2;
float x_speed = 0.1;
float thickness = 5.0;

void setup() {
  size(1280, 720);
  c = height/2;
}

void draw() {
  background(255);
  fill(0);
  d = x_speed * millis();
  for (float x = 0; x < width; x += x_step) {
    ellipse(x, a*sin(b*(x-d))+c, thickness, thickness);
  }
}
