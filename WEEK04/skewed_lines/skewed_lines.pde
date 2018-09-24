size(1024, 720);
int margin = 150;
int line_w = 150;
int start_x;
int start_y = height - margin;
for (int i = 0; i < 5; i++) {
  start_x = width/7 * (i+1);
  line(start_x, start_y, start_x + line_w, margin);
}
