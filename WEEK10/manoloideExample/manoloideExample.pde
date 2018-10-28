Disc[] discs = new Disc[7];
color[] colors = {#EBC52C, #1A98F1, #C9CF65, #FC171D, #9CCCF4, #446515, #ADC127};

void setup() {
  size(720, 720);
  strokeWeight(1);
  strokeCap(SQUARE);
  stroke(0, 100);
  for (int i = 0; i < discs.length; i++ ) {
    discs[i] = new Disc();
  }
}

void draw() {
  //background(#D1DFFA);
  background(255);
  for (int i = 0; i < discs.length; i++) {
    discs[i].update();
    discs[i].display();
  }
}
