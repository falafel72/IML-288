int num_balls = 50;
BouncyBall[] balls = new BouncyBall[num_balls];

void setup() {
  size(1280, 720);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new BouncyBall();
  }
}

void draw() {
  background(0);
  for (int i = 0 ; i < balls.length; i++) {
    balls[i].update();
    balls[i].display();
  }
}
