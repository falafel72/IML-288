// Insp: http://learningprocessing.com/examples/chp05/example-05-09-gravity

float max_dist = 300.0;

int num_balls = 50;
BouncyBall[] balls = new BouncyBall[num_balls];

void setup() {
  size(1280, 720, P3D);
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new BouncyBall();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
    balls[i].display();

    for (int j = 0; j < balls.length; j++) {
      PVector b1 = new PVector(balls[i].x, balls[i].y);
      PVector b2 = new PVector(balls[j].x, balls[j].y);
      float dist = b1.dist(b2);
      if (dist < max_dist) {
        float alpha = 1.0 - dist/max_dist;
        stroke(balls[i].c, alpha * 255);
        line(b1.x, b1.y, b2.x, b2.y);
      }
    }
  }
}
