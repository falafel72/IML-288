// CANVAS //<>//
int margin = 50;
int canvas_w = 1000;
int canvas_h = 620;
int canvas_bg = 1;

// BRUSH
float x, y, px, py, targetX, targetY;
float easing = 0.2;
float stroke_weight;
String brush_stroke = "bw";

// SYMMETRY
int canvas_symmetry = 0;
color guides = #56FFFE;
PImage symmetry_source, symmetry_target;

// CONTROLS
int panel_left = 1080;
int button_sz = 48;
int button_radius = 5;
PFont system_font, button_font;
ClearPill clear;
SymmetryButton none, horizontal, vertical, quarters;
BgButton white, black;
StrokeButton bw, gb, rb, ry;
Button[] buttons = new Button[10];

////////// SETUP //////////

void setup() {
  size(1280, 720);
  background(220);
  // Create fonts
  system_font = createFont("Karla-Regular.ttf", 26);
  button_font = createFont("Karla-Bold.ttf", 22);
  // Create controls
  textAlign(LEFT, TOP);
  textFont(system_font);
  // Canvas
  fill(0);
  text("CANVAS", panel_left, 50);
  ellipseMode(CORNER);
  clear = new ClearPill(panel_left, 90, 110, button_sz);
  // Symmetry
  fill(0);
  text("SYMMETRY", panel_left, 170);
  none = new SymmetryButton(0, loadImage("sym_icon_n.png"), panel_left, 210);
  horizontal = new SymmetryButton(1, loadImage("sym_icon_h.png"), panel_left + 70, 210);
  vertical = new SymmetryButton(2, loadImage("sym_icon_v.png"), panel_left, 280);
  quarters = new SymmetryButton(3, loadImage("sym_icon_q.png"), panel_left + 70, 280);
  // Background
  fill(0);
  text("BACKGROUND", panel_left, 360);
  white = new BgButton(1, loadImage("bg_icon_w.png"), panel_left, 400);
  black = new BgButton(0, loadImage("bg_icon_b.png"), panel_left + 70, 400);
  // Stroke
  fill(0);
  text("STROKE", panel_left, 480);
  bw = new StrokeButton("bw", loadImage("stroke_icon_bw.png"), panel_left, 520);
  gb = new StrokeButton("gb", loadImage("stroke_icon_gb.png"), panel_left + 70, 520);
  rb = new StrokeButton("rb", loadImage("stroke_icon_rb.png"), panel_left, 590);
  ry = new StrokeButton("ry", loadImage("stroke_icon_ry.png"), panel_left + 70, 590);
  // Add buttons to array
  buttons[0] = none;
  buttons[1] = horizontal;
  buttons[2] = vertical;
  buttons[3] = quarters;
  buttons[4] = white;
  buttons[5] = black;
  buttons[6] = bw;
  buttons[7] = gb;
  buttons[8] = rb;
  buttons[9] = ry;
  // Create canvas
  clearCanvas();
  // Create PImage to enable symmetry functionality
  symmetry_source = createImage(canvas_w, canvas_h, RGB);
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
    if (stroke_weight < 5) {
      // Set lower limit for stroke_weight
      stroke_weight = 5;
    } else if (stroke_weight > 100) {
      // Set upper limit for stroke_weight
      stroke_weight = 100;
    }
    strokeWeight(stroke_weight);
    // If mouse pressed, then draw line
    if (mousePressed) {
      if (mouseX > margin && mouseX < margin + canvas_w &&
        mouseY > margin && mouseY < margin + canvas_h) {
        setStrokeColor();
        line(px, py, x, y);
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
  // Create canvas
  strokeWeight(1);
  if (canvas_bg == 0) {
    fill(0);
  } else if (canvas_bg == 1) {
    fill(255);
  }
  rect(margin, margin, canvas_w, canvas_h);
  // Create guides
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
  }
}

void setStrokeColor() {
  // For default bw, set stroke to opposite of background color
  if (brush_stroke == "bw") {
    if (canvas_bg == 0) {
      stroke(255);
    } else if (canvas_bg == 1) {
      stroke(0);
    }
  } else {
    float r = 0;
    float g = 0;
    float b = 0;
    if (brush_stroke == "gb") {
      r = 0;
      g = map(mouseX, margin, margin + canvas_w, 100, 255);
      b = map(mouseY, margin, margin + canvas_h, 100, 255);
    } else if (brush_stroke == "rb") {
      r = map(mouseX, margin, margin + canvas_w, 100, 255);
      g = 0;
      b = map(mouseY, margin, margin + canvas_h, 100, 255);
    } else if (brush_stroke == "ry") {
      r = 255;
      // Map g diagonally from upper right to bottom left
      g = map(
        // Pythagoras, using an inverted x
        sqrt(pow(margin+canvas_w - mouseX, 2) + pow(mouseY, 2)), 
        // Upper and lower corners of canvas
        margin, sqrt(pow(margin+canvas_w, 2) + pow(margin+canvas_h, 2)), 
        0, 255
        );
      // Map b diagonaly from upper left to bottom right
      b = map(
        sqrt(pow(mouseX, 2) + pow(mouseY, 2)), 
        margin, sqrt(pow(margin+canvas_w, 2) + pow(margin+canvas_h, 2)), 
        0, 100
        );
    }
    stroke(color(r, g, b));
  }
}

void drawSymmetry() {
  switch(canvas_symmetry) {
  case 0:
    // If canvas_symmetry == 0, do nothing
    break;
  case 1:
    if (mouseX <= margin + canvas_w/2) {
      // Get left half of canvas and reflect it horizontally
      symmetry_source = get(margin, margin, canvas_w/2 - 1, canvas_h);
      pushMatrix();
      translate(margin + canvas_w/4, margin + canvas_h/2);
      scale(-1, 1);
      image(symmetry_source, -canvas_w*3/4 - 1, -canvas_h/2);
      popMatrix();
    } else if (mouseX > margin + canvas_w/2) {
      // Get right half of canvas and reflect it horizontally
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
      // Get upper half of canvas and reflect it vertically
      symmetry_source = get(margin, margin, canvas_w, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, -canvas_h*3/4 - 1);
      popMatrix();
    } else if (mouseY > margin + canvas_h/2) {
      // Get lower half of canvas and reflect it vertically
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
      // Get upper left quadrant of canvas and reflect it horizontally
      symmetry_source = get(margin, margin, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/4, margin + canvas_h/4);
      scale(-1, 1);
      image(symmetry_source, -canvas_w*3/4 - 1, -canvas_h/4);
      popMatrix();
      // Get new upper half of canvas and reflect it vertically
      symmetry_source = get(margin, margin, canvas_w, canvas_h/2);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, -canvas_h*3/4 - 1);
      popMatrix();
    } else if (mouseX > margin + canvas_w/2 && mouseY <= margin + canvas_h/2) {
      // Get upper right quadrant of canvas and reflect it horizontally
      symmetry_source = get(margin + canvas_w/2 + 1, margin, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w*3/4, margin + canvas_h/4);
      scale(-1, 1);
      image(symmetry_source, canvas_w/4, -canvas_h/4);
      popMatrix();
      // Get new upper half of canvas and reflect it vertically
      symmetry_source = get(margin, margin, canvas_w, canvas_h/2);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, -canvas_h*3/4 - 1);
      popMatrix();
    } else if (mouseX <= margin + canvas_w/2 && mouseY > margin + canvas_h/2) {
      // Get lower left quadrant of canvas and reflect it horizontally
      symmetry_source = get(margin, margin + canvas_h/2 + 1, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/4, margin + canvas_h*3/4);
      scale(-1, 1);
      image(symmetry_source, -canvas_w*3/4 - 1, -canvas_h/4 + 1);
      popMatrix();
      // Get new lower half of canvas and reflect it vertically
      symmetry_source = get(margin, margin + canvas_h/2 + 1, canvas_w, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w/2, margin + canvas_h*3/4);
      scale(1, -1);
      image(symmetry_source, -canvas_w/2, canvas_h/4);
      popMatrix();
    } else if (mouseX > margin + canvas_w/2 && mouseY > margin + canvas_h/2) {
      // Get lower right quadrant of canvas and reflect it horizontally
      symmetry_source = get(margin + canvas_w/2 + 1, margin + canvas_h/2 + 1, canvas_w/2 - 1, canvas_h/2 - 1);
      pushMatrix();
      translate(margin + canvas_w*3/4, margin + canvas_h*3/4);
      scale(-1, 1);
      image(symmetry_source, canvas_w/4, -canvas_h/4 + 1);
      popMatrix();
      // Get new lower half of canvas and reflect it vertically
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

////////// CLEAR PILL //////////

class ClearPill {
  float x, y, w, h;
  float padding_x = 23;
  float padding_y = 11;

  ClearPill(float x, float y, float w, float h) {
    // Shift slightly left to compensate for arc of button edge
    this.x = x - 10;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  // Create different icon states based on mouse control
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

////////// END CLEAR PILL //////////

////////// BUTTONS //////////

class Button {
  float x, y;
  PImage icon;

  Button() {
  }

  //Button(PImage icon, float x, float y, float w, float h) {
  Button(PImage icon, float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    //this.w = w;
    //this.h = h;
    this.icon = icon;

    createDefault();
  }

  public void checkMouseOver() {
  }

  boolean isMouseOver() {
    return (mouseX > x && mouseX < x + button_sz &&
      mouseY > y && mouseY < y + button_sz);
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
    rect(x, y, button_sz, button_sz, button_radius);
    image(icon, x, y, button_sz, button_sz);
  }
}

class SymmetryButton extends Button {
  int symmetry;

  SymmetryButton(int symmetry, PImage icon, 
    float x, float y) {
    super(icon, x, y, button_sz, button_sz);
    this.symmetry = symmetry;
    this.icon = icon;
  }

  // Create different icon states based on mouse control and canvas symmetry
  public void checkMouseOver() {
    if (super.isMouseOver() && mousePressed) {
      setSymmetry();
    } else if (super.isMouseOver()) {
      if (canvas_symmetry == symmetry) {
        super.createSelected();
      } else {
        super.createHighlighted();
      }
    } else {
      if (canvas_symmetry == symmetry) {
        super.createSelected();
      } else {
        super.createDefault();
      }
    }
  }

  public void setSymmetry() {
    canvas_symmetry = symmetry;
    createSelected();
    clearCanvas();
  }
}

class BgButton extends Button {
  int bg;

  BgButton(int bg, PImage icon, 
    float x, float y) {
    super(icon, x, y, button_sz, button_sz);
    this.bg = bg;
  }

  // Create different icon states based on mouse control and canvas background
  public void checkMouseOver() {
    if (super.isMouseOver() && mousePressed) {
      setBg();
    } else if (super.isMouseOver()) {
      if (canvas_bg == bg) {
        super.createSelected();
      } else {
        super.createHighlighted();
      }
    } else {
      if (canvas_bg == bg) {
        super.createSelected();
      } else {
        super.createDefault();
      }
    }
  }

  public void setBg() {
    canvas_bg = bg;
    createSelected();
    clearCanvas();
  }
}

class StrokeButton extends Button {
  String stroke;

  StrokeButton(String stroke, PImage icon, 
    float x, float y) {
    super(icon, x, y, button_sz, button_sz);
    this.stroke = stroke;
  }

  // Create different icon states based on mouse control and brush stroke
  public void checkMouseOver() {
    if (super.isMouseOver() && mousePressed) {
      setStroke();
    } else if (super.isMouseOver()) {
      if (brush_stroke == stroke) {
        super.createSelected();
      } else {
        super.createHighlighted();
      }
    } else {
      if (brush_stroke == stroke) {
        super.createSelected();
      } else {
        super.createDefault();
      }
    }
  }

  public void setStroke() {
    brush_stroke = stroke;
    createSelected();
    clearCanvas();
  }
}

////////// END BUTTONS //////////

////////// MOUSE CONTROL //////////

void checkMouseControl() {
  clear.checkMouseOver();
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].checkMouseOver();
  }
}
