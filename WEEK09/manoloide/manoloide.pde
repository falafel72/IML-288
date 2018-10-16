float tile_size = 60.0;
color[] colors = {#F2794A, #FECF4A, #4BC38C, #16858B, #323741};
//color[] colors = new color[5];

void setup() {
  size(720, 720, P3D);
  //colorMode(HSB, 360, 100, 100);
  //colors[0] = color(16.8, 69.4, 94.9);
  //colors[1] = color(44.3, 70.9, 99.6);
  //colors[2] = color(152.5, 61.5, 76.5);
  //colors[3] = color(183.1, 84.2, 54.5);
  //colors[4] = color(220, 23.1, 25.5);
  noLoop();
}

void draw() {
  for (float i = 0; i < width; i += tile_size) {
    for (float j = 0; j < height; j += tile_size) {
      drawTile(i, j);
    }
  }
}

void drawTile(float x, float y) {
  float cx = x + tile_size/2;
  float cy = y + tile_size/2;

  // Tile
  stroke(255);
  color c = colors[int(random(colors.length))];
  fill(c);
  rect(x, y, tile_size, tile_size);
  //if (random(1) < 0.5) {
  //  color inner = color(hue(c), saturation(c), 100);
  //  for (float diam = tile_size + 10; diam > 0; diam--) {
  //    fill(lerpColor(c, inner, diam/tile_size));
  //    ellipse(cx, cy, diam, diam);
  //  }
  //} else {
  //  fill(c);
  //  rect(x, y, tile_size, tile_size);
  //}
  // Corner gradient
  if (random(1) < 0.5) {
    noStroke();
    beginShape(TRIANGLES);
    fill(255, random(100));
    vertex(x, y);
    fill(255, random(100));
    vertex(x + tile_size, y);
    fill(255, random(100));
    vertex(x, y + tile_size);
    endShape();
  }
  // Center ellipse
  fill(255);
  noStroke();
  ellipse(cx, cy, 7, 7);
  // Horizontal or vertical line
  stroke(255);
  if (random(1) < 0.5) {
    if (random(1) < 0.5) {
      line(x, cy, x + tile_size, cy);
    } else {
      line(cx, y, cx, y + tile_size);
    }
  }
  // Larger circles
  noFill();
  if (random(1) < 0.5) {
    ellipse(cx, cy, tile_size, tile_size);
  }
  if (random(1) < 0.5) {
    ellipse(cx, cy, tile_size/2, tile_size/2);
  }
  // Center dot
  fill(colors[int(random(colors.length))]);
  if (random(1) < 0.5) {
    ellipse(cx, cy, 3, 3);
  }
}
