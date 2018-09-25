float line_start_x, line_start_y, line_end_x, line_end_y;

void setup() {
  size(1280, 720);
  //noCursor();
}

void draw() {
  //background(204);
  line_start_x = pmouseX;
  line_start_y = pmouseY;
  line_end_x = mouseX;
  line_end_y = mouseY;
  if (line_start_x != 0 && line_start_y != 0 && keyPressed) {
    line(line_start_x, line_start_y, line_end_x, line_end_y);
  }
} 
