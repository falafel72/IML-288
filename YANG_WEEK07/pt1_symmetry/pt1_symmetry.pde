// CANVAS
int margin = 50;
int canvas_w = 1000;
int canvas_h = 620;

// BRUSH
float x, y, px, py, targetX, targetY;
float easing = 0.1;
float stroke_weight;

// SYMMETRY
int canvas_symmetry = 0;
color guides = #56FFFE;

// CONTROLS
int controls_left_x = 1080;
int controls_height = 48;
PFont en_system_font, en_button_font;
ClearButton clear;
SymmetryButton none, horizontal, vertical, quarters, sixths;
PImage icon_n, icon_h, icon_v, icon_q, icon_s;

////////// SETUP //////////

void setup() {
  size(1280, 720);
  background(220);
  clearCanvas();
  // Create fonts
  en_system_font = createFont("Karla-Regular.ttf", 32);
  en_button_font = createFont("Karla-Bold.ttf", 24);
  // Create icons
  icon_n = loadImage("icon_none.png");
  icon_h = loadImage("icon_horizontal.png");
  icon_v = loadImage("icon_vertical.png");
  icon_q = loadImage("icon_quarters.png");
  icon_s = loadImage("icon_sixths.png");
  // Create controls
  textAlign(LEFT, TOP);
  textFont(en_system_font);
  fill(0);
  text("CANVAS", controls_left_x, margin);
  clear = new ClearButton(controls_left_x, 100, 92, 48);
  text("SYMMETRY", controls_left_x, 200);
  none = new SymmetryButton(0, icon_n, 
    controls_left_x, 250, controls_height, controls_height);
  horizontal = new SymmetryButton(1, icon_h, 
    controls_left_x, 325, controls_height, controls_height);
  vertical = new SymmetryButton(2, icon_v, 
    controls_left_x, 400, controls_height, controls_height);
  quarters = new SymmetryButton(3, icon_q, 
    controls_left_x, 475, controls_height, controls_height);
  sixths = new SymmetryButton(4, icon_s, 
    controls_left_x, 550, controls_height, controls_height);
}

////////// END SETUP //////////

////////// DRAW //////////

void clearCanvas() {
  strokeWeight(1);
  fill(255);
  rect(margin, margin, canvas_w, canvas_h);
  stroke(guides);
  switch(canvas_symmetry) {
  case 0:
    break;
  case 1:
    line(margin + canvas_w/2, margin + 1, 
      margin + canvas_w/2, margin + canvas_h - 1);
    break;
  case 2:
    line(margin + 1, margin + canvas_h/2, 
      margin + canvas_w - 1, margin + canvas_h/2);
    break;
  case 3:
    line(margin + canvas_w/2, margin + 1, 
      margin + canvas_w/2, margin + canvas_h - 1);
    line(margin + 1, margin + canvas_h/2, 
      margin + canvas_w - 1, margin + canvas_h/2);
    break;
  case 4:
    line(margin + canvas_w/2, margin + 1, 
      margin + canvas_w/2, margin + canvas_h - 1);
    line(margin + 1, margin + canvas_h/2, 
      margin + canvas_w - 1, margin + canvas_h/2);
    line(margin + 1, margin + 1, 
      margin + canvas_w - 1, margin + canvas_h - 1);
    line(margin + canvas_w - 1, margin + 1, 
      margin + 1, margin + canvas_h - 1);
    break;
  }
}

void draw() {
  if (mouseX > margin && mouseX < margin + canvas_w &&
    mouseY > margin && mouseY < margin + canvas_h) {
    targetX = mouseX;
    // Interpolate between x and targetX
    x += (targetX - x) * easing;
    targetY = mouseY;
    // Interpolate between y and targetY
    y += (targetY - y) * easing;
    // Change stroke weight depending on mouse speed
    stroke_weight = dist(px, py, x, y);
    // Set lower limit for stroke_weight
    if (stroke_weight < 5) {
      stroke_weight = 5;
      // Set upper limit for stroke_weight
    } else if (stroke_weight > 100) {
      stroke_weight = 100;
    }
    strokeWeight(stroke_weight);
    // If mousePressed, then draw line
    checkMouseDraw();
    // Update px and py to new positions
    px = x;
    py = y;
  } else {
    checkMouseControl();
  }
}

void checkMouseDraw() {
  if (mousePressed) {
    if (mouseX > margin && mouseX < margin + canvas_w &&
      mouseY > margin && mouseY < margin + canvas_h) {
      stroke(0);
      line(px, py, x, y);
    }
  }
}

////////// END DRAW //////////

////////// BUTTON CONTROLS //////////

class ClearButton {
  float x, y, w, h;
  float padding = 10.0;

  ClearButton(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void createDefault() {
    fill(220);
    strokeWeight(2);
    rect(x, y, w, h);
    fill(0);
    textFont(en_button_font);
    text("CLEAR", x + padding, y + padding);
  }

  void createHighlighted() {
    fill(230);
    strokeWeight(2);
    rect(x, y, w, h);
    fill(0);
    textFont(en_button_font);
    text("CLEAR", x + padding, y + padding);
  }

  public boolean isMouseOver() {
    if (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h) {
      createHighlighted();
      return true;
    }
    createDefault();
    return false;
  }
}

class SymmetryButton {
  float x, y, w, h;
  int symmetry;
  PImage icon;

  SymmetryButton(int symmetry, PImage icon, 
    float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.symmetry = symmetry;
    this.icon = icon;

    createDefault();
  }

  void createDefault() {
    fill(220);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);
    image(icon, x, y, 48, 48);
  }

  void createHighlighted() {
    fill(230);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);
    image(icon, x, y, 49, 49);
  }

  public boolean isMouseOver() {
    if (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h) {
      createHighlighted();
      return true;
    }
    createDefault();
    return false;
  }

  void setSymmetry() {
    canvas_symmetry = symmetry;
    println(canvas_symmetry);
    clearCanvas();
  }
}

////////// END BUTTON CONTROLS //////////

////////// MOUSE CONTROL //////////

void checkMouseControl() {
  if (clear.isMouseOver()) {
    if (mousePressed) {
      clearCanvas();
    }
  }
  if (none.isMouseOver()) {
    if (mousePressed) {
      none.setSymmetry();
    }
  }
  if (horizontal.isMouseOver()) {
    if (mousePressed) {
      horizontal.setSymmetry();
    }
  }
  if (vertical.isMouseOver()) {
    if (mousePressed) {
      vertical.setSymmetry();
    }
  }
  if (quarters.isMouseOver()) {
    if (mousePressed) {
      quarters.setSymmetry();
    }
  }
  if (sixths.isMouseOver()) {
    if (mousePressed) {
      sixths.setSymmetry();
    }
  }
}
