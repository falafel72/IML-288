RandC[] rc = new RandC[20];
color[] colors = {#71AA62, #ECC342, #F3483A, #EFECDE, #2B88CB};

void setup() {
  size(720, 720);
  for (int i = 0; i < rc.length; i++) {
    rc[i] = new RandC();
  }
  noFill();
  strokeCap(SQUARE);
}

void draw() {
  background(#95856D);
  for (int i = 0; i < rc.length; i++) {
    rc[i].move();
    rc[i].display();
  }
}
