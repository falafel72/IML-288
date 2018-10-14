PImage sally;
PImage faceb_still, faceb_walkr, faceb_walkl;
PImage facer_still, facer_walk;
PImage facef_still, facef_walkr, facef_walkl;
PImage facel_still, facel_walk;
int sprite;
int startTime;
int delay = 150;

int w = 32;
int h = 64;
float x = 50;
float y = 50;
float x_speed, y_speed;
String dir;

void setup() {
  size(720, 720);
  
  sally = loadImage("SallyJones_big.png");
  faceb_still = sally.get(16, 0, w, h);
  faceb_walkr = sally.get(16, 64, w, h);
  faceb_walkl = sally.get(80, 64, w, h);
  facer_still = sally.get(16, 128, w, h);
  facer_walk = sally.get(80, 128, w, h);
  facef_still = sally.get(144, 0, w, h);
  facef_walkr = sally.get(80, 192, w, h);
  facef_walkl = sally.get(16, 192, w, h);
  facel_still = sally.get(16, 256, w, h);
  facel_walk = sally.get(80, 256, w, h);

  sprite = 0;
  dir = "d";
  imageMode(CENTER);
  x = width/2;
  y = width/2;
  background(255);
  startTime = millis();
}

void draw() {
  paintSprite();
}

void keyPressed() {
  if (keyCode == UP || keyCode == RIGHT || keyCode == DOWN || keyCode == LEFT) {
    if (keyCode == UP) {
      dir = "u";
    } else if (keyCode == RIGHT) {
      dir = "r";
    } else if (keyCode == DOWN) {
      dir = "d";
    } else if (keyCode == LEFT) {
      dir = "l";
    }
    // Timing code from forum.processing.org/one/topic/timing-animation-with-millis.html
    if (millis() > startTime + delay) {
      startTime = millis();
      sprite++;
    }
  }
}

void keyReleased() {
  sprite = 0;
}

void paintSprite() {
  background(255);
  if (dir == "u") {
    if (sprite == 0) {
      image(faceb_still, x, y);
    } else if (sprite % 2 == 0) {
      image(faceb_walkr, x, y);
    } else if (sprite % 2 == 1) {
      image(faceb_walkl, x, y);
    }
  } else if (dir == "r") {
    if (sprite == 0) {
      image(facer_still, x, y);
    } else if (sprite % 2 == 0) {
      image(facer_still, x, y);
    } else if (sprite % 2 == 1) {
      image(facer_walk, x, y);
    }
  } else if (dir == "d") {
    if (sprite == 0) {
      image(facef_still, x, y);
    } else if (sprite % 2 == 0) {
      image(facef_walkr, x, y);
    } else if (sprite % 2 == 1) {
      image(facef_walkl, x, y);
    }
  } else if (dir == "l") {
    if (sprite == 0) {
      image(facel_still, x, y);
    } else if (sprite % 2 == 0) {
      image(facel_still, x, y);
    } else if (sprite % 2 == 1) {
      image(facel_walk, x, y);
    }
  }
}
