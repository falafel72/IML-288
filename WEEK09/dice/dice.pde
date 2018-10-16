int dice1 = 0;
int dice2 = 0;

void setup() {
  size(720, 720);
  textSize(72);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0);
  text(dice1, width/2 - 100, 360);
  text(dice2, width/2 + 100, 360);
}

void mouseClicked() {
  dice1 = genRandomNumber(36);
  dice2 = genRandomNumber(36);
}

int genRandomNumber(int sides) {
  int dice_value = int(random(sides)) + 1;
  return dice_value;
}

void printRandomNumber() {
  int dice_value = int(random(6)) + 1;
  println(dice_value);
}
