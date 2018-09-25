void setup() {
  size(1280, 720);
}

void draw() {
  //background(220);
  fill(220, 20);
  rect(20, 20, width-40, height-40);
  for (int i = 0; i < 100; i++) {
    line(random(20, width-40), random(20, height-40), 
      random(20, width-40), random(20, height-40));
  }
}
