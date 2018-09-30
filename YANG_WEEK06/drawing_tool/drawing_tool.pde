// CANVAS
int margin = 50;
int canvas_w = 800;
int canvas_h = 620;

// BRUSH
float x, y, px, py, targetX, targetY;
float easing = 0.1;
float stroke_weight;

void setup() {
  size(1280, 720);
  background(220);
  fill(250);
  rect(margin, margin, canvas_w, canvas_h);
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
    if (mousePressed) {
      line(px, py, x, y);
    }
    px = x;
    py = y;
  }
}
