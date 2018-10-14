// Sally sprite from opengameart.org/content/48-animated-old-school-rpg-characters-16x16
//// (CC-BY 3.0)
// Forest tiles from opengameart.org/content/forest-tiles (CC0)

PImage sally;
PImage faceb_still, faceb_walkr, faceb_walkl;
PImage facer_still, facer_walk;
PImage facef_still, facef_walkr, facef_walkl;
PImage facel_still, facel_walk;
int sprite;
int startTime;
int delay = 150;

PImage forest;
PImage grass;
PImage[] bg_features = new PImage[12];
PImage bg;
int tile_w = 60;

int w = 32;
int h = 64;
float x, y;
float step = 8;
String dir;

void setup() {
  size(720, 720);

  // SALLY
  sally = loadImage("SallyJones.png");
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
  
  // BACKGROUND
  forest = loadImage("forest_tiles.png");
  grass = forest.get(0, 0, tile_w, tile_w);
  bg_features[0] = forest.get(0, 120, tile_w, tile_w);
  bg_features[1] = forest.get(60, 180, tile_w, tile_w);
  bg_features[2] = forest.get(120, 120, tile_w, tile_w);
  bg_features[3] = forest.get(0, 240, tile_w, tile_w);
  bg_features[4] = forest.get(60, 300, tile_w, tile_w);
  bg_features[5] = forest.get(120, 240, tile_w, tile_w);
  bg_features[6] = forest.get(180, 300, tile_w, tile_w);
  bg_features[7] = forest.get(0, 360, tile_w, tile_w);
  bg_features[8] = forest.get(60, 420, tile_w, tile_w);
  bg_features[9] = forest.get(120, 360, tile_w, tile_w);
  bg_features[10] = forest.get(180, 420, tile_w, tile_w);
  bg_features[11] = forest.get(240, 360, tile_w, tile_w);

  sprite = 0;
  dir = "d";
  imageMode(CENTER);
  x = width/2;
  y = width/2;
  //background(255);
  createBackground();
  startTime = millis();
}

void createBackground() {
  int f;
  for (int i = tile_w/2; i < width; i += tile_w) {
    for (int j = tile_w/2; j < height; j += tile_w) {
      image(grass, i, j);
      f = int(random(96));
      if (f < 12) {
        image(bg_features[f], i, j);
      }
    }
  }
  bg = createImage(width, height, RGB);
  bg = get();
}

void draw() {
  paintSprite();
  if (mouseX > x - w/2 && mouseX < x + w/2 &&
    mouseY > y - h/2 && mouseY < y + h/2 &&
    sprite == 0) {
    println("hover");
  } else {
    println("not hover");
  }
}

void keyPressed() {
  if (keyCode == UP || keyCode == RIGHT || keyCode == DOWN || keyCode == LEFT) {
    if (keyCode == UP) {
      dir = "u";
      y -= step;
    } else if (keyCode == RIGHT) {
      dir = "r";
      x += step;
    } else if (keyCode == DOWN) {
      dir = "d";
      y += step;
    } else if (keyCode == LEFT) {
      dir = "l";
      x -= step;
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
  //background(255);
  image(bg, width/2, height/2);
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
