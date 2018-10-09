float x, y;
float x_speed = 4.0;
float y_speed = 6.0;
float diam = 40.0;
float paddle1_x, paddle1_y;
float paddle2_x, paddle2_y;
float paddle_w = 10.0;
float paddle_h = 100.0;
float paddle_shift = 40.0;

int score1 = 0;
int score2 = 0;

void setup() {
  size(1280, 720);
  rectMode(CENTER);

  x = width/2;
  y = height/2;

  paddle1_x = 40.0;
  paddle1_y = height/2;
  paddle2_x = width - 40.0;
  paddle2_y = height/2;
}

void draw() {
  background(0);
  ellipse(x, y, diam, diam);
  x += x_speed;
  y += y_speed;
  // y
  if (y < diam/2) {
    y = diam/2;
    y_speed = -y_speed;
  } else if (y > height - diam/2) {
    y = height - diam/2;
    y_speed = -y_speed;
  }
  // x
  if (x <= paddle1_x + diam/2 &&
    x > 0 &&
    abs(y - paddle1_y) < paddle_h/2) {
    x_speed = -x_speed;
  } else if (x >= paddle2_x - diam/2 &&
    x < width &&
    abs(y - paddle1_y) < paddle_h/2) {
    x_speed = -x_speed;
  } else if (x < -diam/2) {
    score2++;
    x = width/2;
    y = height/2;
  } else if (x > width + diam/2) {
    score1++;
    x = width/2;
    y = height/2;
  }
  rect(paddle1_x, paddle1_y, paddle_w, paddle_h);
  rect(paddle2_x, paddle2_y, paddle_w, paddle_h);
  
  textSize(40);
  text(score1, width/2 - 200, 100);
  text(score2, width/2 + 200, 100);
}

void keyPressed() {
  if (key == 'q') {
    paddle1_y -= paddle_shift;
  } else if (key == 'a') {
    paddle1_y += paddle_shift;
  } else if (key == 'p') {
    paddle2_y -= paddle_shift;
  } else if (key == 'l') {
    paddle2_y += paddle_shift;
  } else if (key == ' ') {
    x = width/2;
    y = height/2;
    x_speed = random(4.0, 10.0);
    y_speed = random(4.0, 10.0);
  }
}
