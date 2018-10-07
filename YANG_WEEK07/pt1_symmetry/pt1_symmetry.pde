// CANVAS
int margin = 50;
int canvas_w = 1000;
int canvas_h = 620;

// BRUSH
float x, y, px, py, targetX, targetY;
float easing = 0.2;
float stroke_weight;

// SYMMETRY
int canvas_symmetry = 0;
color guides = #56FFFE;
PImage symmetry_source, symmetry_target;

// CONTROLS
int controls_left_x = 1080;
int controls_height = 48;
int button_radius = 5;
PFont system_font, button_font;
ClearPill clear;
//SymmetryButton none, horizontal, vertical, quarters, sixths;
SymmetryButton none, horizontal, vertical, quarters;
//SymmetryButton[] buttons = new SymmetryButton[5];
SymmetryButton[] buttons = new SymmetryButton[4];

////////// SETUP //////////

void setup() {
  size(1280, 720);
  background(220);
  // Create fonts
  system_font = createFont("Karla-Regular.ttf", 32);
  button_font = createFont("Karla-Bold.ttf", 24);
  // Create controls
  textAlign(LEFT, TOP);
  textFont(system_font);
  fill(0);
  text("CANVAS", controls_left_x, margin);
  ellipseMode(CORNER);
  clear = new ClearPill(controls_left_x, 100, 110, controls_height);
  text("SYMMETRY", controls_left_x, 200);
  //none = new SymmetryButton(0, icon_n, 
  //  controls_left_x, 250, controls_height, controls_height);
  none = new SymmetryButton(0, loadImage("sym_icon_n.png"), 
    controls_left_x, 250, controls_height, controls_height);
  horizontal = new SymmetryButton(1, loadImage("sym_icon_h.png"), 
    controls_left_x + 75, 250, controls_height, controls_height);
  vertical = new SymmetryButton(2, loadImage("sym_icon_v.png"), 
    controls_left_x, 325, controls_height, controls_height);
  quarters = new SymmetryButton(3, loadImage("sym_icon_q.png"), 
    controls_left_x + 75, 325, controls_height, controls_height);
  //sixths = new SymmetryButton(4, icon_s, 
  //  controls_left_x, 550, controls_height, controls_height);
  buttons[0] = none;
  buttons[1] = horizontal;
  buttons[2] = vertical;
  buttons[3] = quarters;
  //buttons[4] = sixths;
  // Create canvas
  clearCanvas();
  // Set default symmetry to none
  none.setSymmetry();
}

////////// END SETUP //////////

////////// DRAW //////////

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
    if (mousePressed) {
      if (mouseX > margin && mouseX < margin + canvas_w &&
        mouseY > margin && mouseY < margin + canvas_h) {
        line(px, py, x, y);
        symmetry_source = createImage(canvas_w, canvas_h, RGB);
        drawSymmetry();
      }
    }
    // Update px and py to new positions
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
    //case 4:
    //  line(margin + canvas_w/2, margin + 1, 
    //    margin + canvas_w/2, margin + canvas_h - 1);
    //  line(margin + 1, margin + canvas_h/2, 
    //    margin + canvas_w - 1, margin + canvas_h/2);
    //  line(margin + 1, margin + 1, 
    //    margin + canvas_w - 1, margin + canvas_h - 1);
    //  line(margin + canvas_w - 1, margin + 1, 
    //    margin + 1, margin + canvas_h - 1);
    //  break;
  }
}

void drawSymmetry() {
  switch(canvas_symmetry) {
  case 0:
    break;
  case 1:
    if (mouseX <= margin + canvas_w/2) {
      symmetry_source = get(margin, margin, canvas_w/2 - 1, canvas_h);
      pushMatrix();
      translate(margin + canvas_w/4, margin + canvas_h/2);
      scale(-1, 1);
      image(symmetry_source, -canvas_w*3/4 - 1, -canvas_h/2);
      popMatrix();
    } else if (mouseX > margin + canvas_w/2) {
      symmetry_source = get(margin + canvas_w/2 + 1, margin, canvas_w/2 - 1, canvas_h);
      pushMatrix();
      translate(margin + canvas_w*3/4, margin + canvas_h/2);
      scale(-1, 1);
      image(symmetry_source, canvas_w/4, -canvas_h/2);
      popMatrix();
    }
    break;
  case 2:
    if (mouseY <= margin + canvas_h/2) {
      symmetry_source = get(margin, margin, canvas_w, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, -canvas_h*3/4 - 1);
      popMatrix();
    } else if (mouseY > margin + canvas_h/2) {
      symmetry_source = get(margin, margin + canvas_h/2 + 1, canvas_w, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h*3/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, canvas_h/4);
      popMatrix();
    }
    break;
  case 3:
    if (mouseX <= margin + canvas_w/2 && mouseY <= margin + canvas_h/2) {
      symmetry_source = get(margin, margin, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/4, margin + canvas_h/4);
      scale(-1, 1);
      image(symmetry_source, -canvas_w*3/4 - 1, -canvas_h/4);
      popMatrix();
      symmetry_source = get(margin, margin, canvas_w, canvas_h/2);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, -canvas_h*3/4 - 1);
      popMatrix();
    } else if (mouseX > margin + canvas_w/2 && mouseY <= margin + canvas_h/2) {
      symmetry_source = get(margin + canvas_w/2 + 1, margin, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w*3/4, margin + canvas_h/4);
      scale(-1, 1);
      image(symmetry_source, canvas_w/4, -canvas_h/4);
      popMatrix();
      symmetry_source = get(margin, margin, canvas_w, canvas_h/2);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, -canvas_h*3/4 - 1);
      popMatrix();
    } else if (mouseX <= margin + canvas_w/2 && mouseY > margin + canvas_h/2) {
      symmetry_source = get(margin, margin + canvas_h/2 + 1, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/4, margin + canvas_h*3/4);
      scale(-1, 1);
      image(symmetry_source, -canvas_w*3/4 - 1, -canvas_h/4 + 1);
      popMatrix();
      symmetry_source = get(margin, margin + canvas_h/2 + 1, canvas_w, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h*3/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, canvas_h/4);
      popMatrix();
    } else if (mouseX > margin + canvas_w/2 && mouseY > margin + canvas_h/2) {
      symmetry_source = get(margin + canvas_w/2 + 1, margin + canvas_h/2 + 1, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w*3/4, margin + canvas_h*3/4);
      scale(-1, 1);
      image(symmetry_source, canvas_w/4, -canvas_h/4 + 1);
      popMatrix();
      symmetry_source = get(margin, margin + canvas_h/2 + 1, canvas_w, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h*3/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, canvas_h/4);
      popMatrix();
    }
  }
}

////////// END DRAW //////////

////////// BUTTON CONTROLS //////////

class ClearPill {
  float x, y, w, h;
  float padding_x = 20.0;
  float padding_y = 10.0;

  ClearPill(float x, float y, float w, float h) {
    // Shift to compensate for arc button edge
    this.x = x - 10;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public void checkMouseOver() {
    if (isMouseOver() && mousePressed) {
      createPressed();
      clearCanvas();
    } else if (isMouseOver()) {
      createHighlighted();
    } else {
      createDefault();
    }
  }

  boolean isMouseOver() {
    return (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h);
  }

  void createDefault() {
    fill(220);
    makeButton();
  }

  void createHighlighted() {
    fill(230);
    makeButton();
  }

  void createPressed() {
    fill(200);
    makeButton();
  }

  void makeButton() {
    stroke(0);
    strokeWeight(2);
    beginShape();
    vertex(x+30, y);
    bezierVertex(x, y, x, y+h, x+30, y+h);
    vertex(x+w-30, y+h);
    bezierVertex(x+w, y+h, x+w, y, x+w-30, y);
    endShape(CLOSE);
    fill(0);
    textFont(button_font);
    text("CLEAR", x + padding_x, y + padding_y);
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

  public void checkMouseOver() {
    if (isMouseOver() && mousePressed) {
      setSymmetry();
    } else if (isMouseOver()) {
      if (canvas_symmetry == symmetry) {
        createSelected();
      } else {
        createHighlighted();
      }
    } else {
      if (canvas_symmetry == symmetry) {
        createSelected();
      } else {
        createDefault();
      }
    }
  }

  boolean isMouseOver() {
    return (mouseX > x && mouseX < x + w &&
      mouseY > y && mouseY < y + h);
  }

  void createDefault() {
    fill(220);
    makeButton();
  }

  void createHighlighted() {
    fill(230);
    makeButton();
  }

  void createSelected() {
    fill(200);
    makeButton();
  }

  void makeButton() {
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h, button_radius);
    image(icon, x, y, h, h);
  }

  public void setSymmetry() {
    canvas_symmetry = symmetry;
    createSelected();
    clearCanvas();
  }
}

////////// END BUTTON CONTROLS //////////

////////// MOUSE CONTROL //////////

void checkMouseControl() {
  clear.checkMouseOver();
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].checkMouseOver();
  }
}
