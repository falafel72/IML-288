// Sally sprite: opengameart.org/content/48-animated-old-school-rpg-characters-16x16
//// (CC-BY 3.0)
// Forest tiles: opengameart.org/content/forest-tiles (CC0)
// Plant sprites: opengameart.org/content/sci-fi-plants-and-crystal-things-isometric
//// (CC-BY 3.0)

Sally sally;

PImage forest;
PImage grass;
PImage[] bg_features = new PImage[12];
PImage bg;
int tile_w = 60;

PImage plant_sheet;
PImage[][] plant_growths = new PImage[8][4];
int plant_w = 96;
ArrayList<Plant> plants = new ArrayList<Plant>();

int anim_delay = 150;

void setup() {
  size(720, 720);
  imageMode(CENTER);

  // SALLY
  sally = new Sally();

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

  // PLANTS
  plant_sheet = loadImage("plant_sheet.png");
  for (int i = 0; i < plant_growths.length; i++) {
    for (int j = 0; j < plant_growths[i].length; j++) {
      plant_growths[i][j] = plant_sheet.get(0 + j*plant_w, 0 + i*plant_w, plant_w, plant_w);
    }
  }

  createBackground();
  createPlants();
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

void createPlants() {
  for (int i = 0; i < int(random(80, 100)); i++) {
    plants.add(new Plant());
  }
}

void draw() {
  image(bg, width/2, height/2);
  updatePlants();
  sally.paintSprite();
  //if (mouseX > sprite_x - sprite_w/2 && mouseX < sprite_x + sprite_w/2 &&
  //mouseY > sprite_y - sprite_h/2 && mouseY < sprite_y + sprite_h/2 &&
  //sprite == 0) {
  //println("hover");
  //} else {
  //println("not hover");
  //}
}

void keyPressed() {
  if (keyCode == UP || keyCode == RIGHT || keyCode == DOWN || keyCode == LEFT) {
    sally.updateMovement(keyCode);
  }
}

void keyReleased() {
  sally.stopMovement();
}

class Sally {
  float sprite_x, sprite_y;
  float step = 8;
  int sprite;
  int walk_start;
  String dir;

  PImage sally_sprites;
  PImage faceb_still, faceb_walkr, faceb_walkl;
  PImage facer_still, facer_walk;
  PImage facef_still, facef_walkr, facef_walkl;
  PImage facel_still, facel_walk;
  int sprite_w = 32;
  int sprite_h = 64;

  Sally() {
    sally_sprites = loadImage("SallyJones.png");
    faceb_still = sally_sprites.get(16, 0, sprite_w, sprite_h);
    faceb_walkr = sally_sprites.get(16, 64, sprite_w, sprite_h);
    faceb_walkl = sally_sprites.get(80, 64, sprite_w, sprite_h);
    facer_still = sally_sprites.get(16, 128, sprite_w, sprite_h);
    facer_walk = sally_sprites.get(80, 128, sprite_w, sprite_h);
    facef_still = sally_sprites.get(144, 0, sprite_w, sprite_h);
    facef_walkr = sally_sprites.get(80, 192, sprite_w, sprite_h);
    facef_walkl = sally_sprites.get(16, 192, sprite_w, sprite_h);
    facel_still = sally_sprites.get(16, 256, sprite_w, sprite_h);
    facel_walk = sally_sprites.get(80, 256, sprite_w, sprite_h);

    sprite = 0;
    dir = "d";
    sprite_x = width/2;
    sprite_y = width/2;
    walk_start = millis();
  }

  public void paintSprite() {
    if (dir == "u") {
      if (sprite == 0) {
        image(faceb_still, sprite_x, sprite_y);
      } else if (sprite % 2 == 0) {
        image(faceb_walkr, sprite_x, sprite_y);
      } else if (sprite % 2 == 1) {
        image(faceb_walkl, sprite_x, sprite_y);
      }
    } else if (dir == "r") {
      if (sprite == 0) {
        image(facer_still, sprite_x, sprite_y);
      } else if (sprite % 2 == 0) {
        image(facer_still, sprite_x, sprite_y);
      } else if (sprite % 2 == 1) {
        image(facer_walk, sprite_x, sprite_y);
      }
    } else if (dir == "d") {
      if (sprite == 0) {
        image(facef_still, sprite_x, sprite_y);
      } else if (sprite % 2 == 0) {
        image(facef_walkr, sprite_x, sprite_y);
      } else if (sprite % 2 == 1) {
        image(facef_walkl, sprite_x, sprite_y);
      }
    } else if (dir == "l") {
      if (sprite == 0) {
        image(facel_still, sprite_x, sprite_y);
      } else if (sprite % 2 == 0) {
        image(facel_still, sprite_x, sprite_y);
      } else if (sprite % 2 == 1) {
        image(facel_walk, sprite_x, sprite_y);
      }
    }
  }

  public void updateMovement(int k) {
    if (k == UP) {
      dir = "u";
      sprite_y -= step;
    } else if (k == RIGHT) {
      dir = "r";
      sprite_x += step;
    } else if (k == DOWN) {
      dir = "d";
      sprite_y += step;
    } else if (k == LEFT) {
      dir = "l";
      sprite_x -= step;
    }
    // Timing code from forum.processing.org/one/topic/timing-animation-with-millis.html
    if (millis() > walk_start + anim_delay) {
      walk_start = millis();
      sprite++;
    }
  }

  public void stopMovement() {
    sprite = 0;
  }

  public float getX() {
    return sprite_x;
  }

  public float getY() {
    return sprite_y;
  }
}

class Plant {
  float plant_x, plant_y;
  int type;
  int stage = 0;
  int bloom = 0;
  int bloom_start = 0;

  Plant() {
    plant_x = random(width);
    plant_y = random(height);
    type = int(random(plant_growths.length));
    updateStage();
    bloom_start = millis();
  }

  public void updateStage() {
    if (dist(plant_x, plant_y, sally.getX(), sally.getY()) < 50) {
      if (bloom == 0) {
        bloom = 1;
      }
    } else {
      bloom = -1;
    }
    bloomAnim();
  }

  void bloomAnim() {
    if (bloom == 1) {
      if (millis() > bloom_start + anim_delay && stage < plant_growths[type].length - 1) {
        stage++;
      } else {
        bloom = 0;
      }
    } else if (bloom == -1) {
      if (millis() > bloom_start + anim_delay && stage > 0) {
        stage--;
      } else {
        bloom = 0;
      }
    }
    image(plant_growths[type][stage], plant_x, plant_y);
  }
}

void updatePlants() {
  for (int i = 0; i < plants.size(); i++) {
    plants.get(i).updateStage();
  }
}
