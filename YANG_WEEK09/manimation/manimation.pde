float tile_size = 60.0;
int alpha = 10;
color[] colors = {
  color(242, 121, 74, alpha),
  color(254, 207, 74, alpha),
  color(75, 195, 140, alpha),
  color(22, 133, 139, alpha),
  color(50, 55, 65, alpha)
};
Tile[] tiles = new Tile[144];
int anim_delay = 3000;
float transition_frequency = 0.0005;

void setup() {
  size(720, 720);
  for (float i = 0; i < width; i += tile_size) {
    for (float j = 0; j < height; j += tile_size) {
      tiles[int(i/tile_size*(width/tile_size) + j/tile_size)] = new Tile(i, j);
    }
  }
}

void draw() {
  for (int i = 0; i < tiles.length; i++) {
    tiles[i].drawTile();
    tiles[i].determineTransition();
  }
}

class Tile {
  float x, y;
  float cx, cy;
  color bg_color, cdot_color, upleft_color, upright_color, botleft_color;
  boolean has_gradient, has_line, has_lellipse, has_mellipse, has_cdot;
  int line_orient;
  
  int transition_start;
  boolean in_transition;

  Tile(float x, float y) {
    this.x = x;
    this.y = y;
    cx = x + tile_size/2;
    cy = y + tile_size/2;
    in_transition = false;
    randomise();
  }

  public void randomise() {
    bg_color = colors[int(random(colors.length))];
    cdot_color = colors[int(random(colors.length))];
    upleft_color = color(255, random(10, alpha));
    upright_color = color(255, random(10, alpha));
    botleft_color = color(255, random(10, alpha));
    has_gradient = random(1) < 0.2;
    has_line = random(1) < 0.5;
    if (has_line) line_orient = (random(1) < 0.5) ? 0 : 1;
    has_lellipse = random(1) < 0.5;
    has_mellipse = random(1) < 0.5;
    has_cdot = random(1) < 0.5;
    transition_start = millis();
  }

  void drawTile() {
    // Tile
    stroke(255, alpha);
    fill(bg_color);
    rect(x, y, tile_size, tile_size);
    // Corner gradient
    if (has_gradient) {
      noStroke();
      beginShape(TRIANGLES);
      fill(upleft_color);
      vertex(x, y);
      fill(upright_color);
      vertex(x + tile_size, y);
      fill(botleft_color);
      vertex(x, y + tile_size);
      endShape();
    }
    // Center ellipse
    fill(255, alpha);
    noStroke();
    ellipse(cx, cy, 7, 7);
    // Horizontal or vertical line
    if (has_line) {
      stroke(255, alpha);
      if (line_orient == 0) {
        line(x, cy, x + tile_size, cy);
      } else {
        line(cx, y, cx, y + tile_size);
      }
    }
    // Larger circles
    noFill();
    if (has_lellipse) {
      ellipse(cx, cy, tile_size, tile_size);
    }
    if (has_mellipse) {
      ellipse(cx, cy, tile_size/2, tile_size/2);
    }
    // Center dot
    if (has_cdot) {
      fill(cdot_color);
      ellipse(cx, cy, 3, 3);
    }
  }
  
  public void determineTransition() {
    if (millis() > transition_start + anim_delay) {
      if (in_transition) {
        randomise();
      } else {
        if (random(1) < transition_frequency) {
          in_transition = true;
        }
      }
    }
  }
}
