import processing.sound.*;

// Setup
int margin = 40;
int rect_w;
int rect_h;
int rows = 10;
int columns = 5;
Box[][] boxes = new Box[rows][columns];

// Color
color inactive = #F7B536;
color active = #F7D536;

// Sound
SinOsc sine;
float c = 261.63;
float d = 293.66;
float e = 329.63;
float f = 349.23;
float g = 392.00;
float a = 440.00;
float bb = 466.16;
float c_ = 523.25;
float rest = 0.00;
float[] freqs = {
  c, c, d, rest, c, rest, 
  f, rest, e, rest, rest, rest, 
  c, c, d, rest, c, rest, 
  g, rest, f, rest, rest, rest, 
  c, c, c_, rest, a, rest, 
  f, rest, e, rest, d, rest, rest, rest, 
  bb, bb, a, rest, f, rest, 
  g, rest, f, f, f, f, f
};

void setup() {
  size(720, 720);
  // Calculate widths and heights of boxes
  rect_w = (width - margin*2) / columns;
  rect_h = (height - margin*2) / rows;
  background(255);
  fill(inactive);
  stroke(#867C5F);
  // Create boxes
  int box_num = 0;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      boxes[i][j] = new Box(j*rect_w + margin, i*rect_h + margin, freqs[box_num]);
      rect(j*rect_w + margin, i*rect_h + margin, rect_w, rect_h);
      box_num++;
    }
  }

  // Create sine oscillator
  sine = new SinOsc(this);
}

void draw() {
  // Continuously update boxes
  for (int i = 0; i < boxes.length; i++) {
    for (int j = 0; j < boxes[i].length; j++) {
      boxes[i][j].update();
    }
  }
}

class Box {
  int x, y;
  float freq;

  Box(int x, int y, float freq) {
    this.x = x;
    this.y = y;
    this.freq = freq;
  }

  void update() {
    // Check if mouse on box
    if ((mouseX > x) && (mouseX < x + rect_w) &&
      (mouseY > y) && (mouseY < y + rect_h)) {
      // Play sound
      sine.play(freq, 1.0);
      // Highlight box
      fill(active);
      rect(x, y, rect_w, rect_h);
    } else {
      // Un-highlight box
      fill(inactive);
      rect(x, y, rect_w, rect_h);
      // Stop sound if mouse outside square
      if (!(mouseX > margin && mouseX < width-margin) || 
        !(mouseY > margin && mouseY < height-margin)) {
        sine.stop();
      }
    }
  }
}
