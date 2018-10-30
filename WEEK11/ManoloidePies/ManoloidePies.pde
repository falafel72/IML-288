Pie[] pies = new Pie[5];

void setup() {
  size(720, 720);
  stroke(255);
  for (int i = 0; i < pies.length; i++) {
    pies[i] = new Pie();
  }
}

void draw() {
  background(#FBD751);
  for (int i = 0; i < pies.length; i++) {
    pies[i].update();
    pies[i].display();
  }
}
