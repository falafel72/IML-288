// CANVAS
int margin = 50;
int canvas_w = 800;
int canvas_h = 620;

// BRUSH
float x, y, px, py, targetX, targetY;
float easing = 0.1;
float stroke_weight;

// CONTROLS
int controls_left_x = 900;
int controls_height = 48;
PFont en_system_font, en_button_font, zh_font, zh_char_font;
ClearButton clear;
UndoButton undo;
TemplateButton love, learn, life;

////////// SETUP //////////

void setup() {
  size(1280, 720);
  background(220);
  clearCanvas();
  // Create fonts
  en_system_font = createFont("Karla-Regular.ttf", 32);
  en_button_font = createFont("Karla-Bold.ttf", 24);
  zh_font = createFont("bodang-xingkai.ttf", 32);
  zh_char_font = createFont("bodang-xingkai.ttf", 500);
  textAlign(LEFT, TOP);
  // Create controls
  clear = new ClearButton(controls_left_x, margin, 92, 48);
  textFont(en_system_font);
  fill(0);
  text("TEMPLATES", controls_left_x, 150);
  love = new TemplateButton("LOVE", '爱', 
    controls_left_x, 200, 78, controls_height);
  learn = new TemplateButton("LEARN", '学', 
    controls_left_x + 100, 200, 91, controls_height);
  life = new TemplateButton("LIFE", '活', 
    controls_left_x + 213, 200, 65, controls_height);
  stroke(0);
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
    stroke_weight = dist(px, py, x, y) * 1.5;
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

void clearCanvas() {
  stroke(0);
  strokeWeight(1);
  fill(255);
  rect(margin, margin, canvas_w, canvas_h);
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

class Button {
  float x, y, w, h;
  float padding = 10.0;
  String text;
  
  Button() {}
  
  Button(float x, float y, float w, float h, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }
  
  void createDefault() {
    fill(220);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);
    noStroke();
    fill(0);
    textFont(en_button_font);
    text(text, x + padding, y + padding);
  }
  
  void createHighlighted() {
    fill(230);
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);
    noStroke();
    fill(0);
    textFont(en_button_font);
    text(text, x + padding, y + padding);
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

class ClearButton extends Button {
  ClearButton(float x, float y, float w, float h) {
    super(x, y, w, h, "CLEAR");
  }
}

class UndoButton {
  float x, y;
  float w;
  float h;
  
  UndoButton(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class TemplateButton extends Button {
  char character;

  TemplateButton(String display_text, char character, 
    float x, float y, float w, float h) {
    super(x, y, w, h, display_text);
    this.character = character;
    super.createDefault();
  }

  public void showCharacter() {
    clearCanvas();
    fill(0, 50);
    textFont(zh_char_font);
    text(character, 190, 40);
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
  if (love.isMouseOver()) {
    if (mousePressed) {
      love.showCharacter();
    }
  }
  if (learn.isMouseOver()) {
    if (mousePressed) {
      learn.showCharacter();
    }
  }
  if (life.isMouseOver()) {
    if (mousePressed) {
      life.showCharacter();
    }
  }
}
