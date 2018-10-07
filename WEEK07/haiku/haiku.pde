PFont font;

void setup() {
  size(1280, 720);
  font = loadFont("AvenirNext-Medium-48.vlw");
}

void draw() {
  background(#600F27);
  fill(255);
  textAlign(RIGHT);
  textFont(font);
  text("The lamp once out\n" +
    "Cool stars enter\n" +
    "The window frame.", 1000, 230);
  fill(255, 150);
  text("—Natsume Soseki", 1100, 500);
}
