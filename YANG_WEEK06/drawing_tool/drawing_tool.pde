// CANVAS
int margin = 50;
int canvas_w = 800;
int canvas_h = 620;

// BRUSH
float x, y, px, py, targetX, targetY;
float easing = 0.1;
float stroke_weight;

// CONTROLS
PFont font;
ClearButton clear;

void setup() {
  size(1280, 720);
  background(220);
  clearCanvas();
  //strokeCap(PROJECT);
  font = createFont("MyriadPro-Regular.otf", 32);
  textFont(font);
  textAlign(LEFT, TOP);
  clear = new ClearButton(950, margin);
  stroke(0);
}

void draw() {
  if (mouseX > margin && mouseX < margin + canvas_w &&
    mouseY > margin && mouseY < margin + canvas_h) {
    targetX = mouseX;
    x += (targetX - x) * easing;
    targetY = mouseY;
    y += (targetY - y) * easing;
    stroke_weight = dist(px, py, x, y);
    if (stroke_weight < 5) {
      stroke_weight = 5;
    } else if (stroke_weight > 100) {
      stroke_weight = 100;
    }
    strokeWeight(stroke_weight);
    checkMouseDraw();
    px = x;
    py = y;
  } else {
    checkMouseControl();
  }
}

void clearCanvas() {
  strokeWeight(1);
  fill(255);
  rect(margin, margin, canvas_w, canvas_h);
}

class ClearButton {
  float x, y;
  float padding = 10.0;
  float w = 105.0;
  float h = 48.0;

  ClearButton(float x, float y) {
    this.x = x;
    this.y = y;

    noFill();
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);
    noStroke();
    fill(0);
    text("CLEAR", x + padding, y + padding);
  }

  public boolean mouseOver() {
    return (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h);
  }
}

void checkMouseDraw() {
  if (mousePressed) {
    if (mouseX > margin && mouseX < margin + canvas_w &&
      mouseY > margin && mouseY < margin + canvas_h) {
      fill(0);
      line(px, py, x, y);
    }
  }
}

void checkMouseControl() {
  if (mousePressed) {
    if (clear.mouseOver()) {
      clearCanvas();
    }
  }
}
