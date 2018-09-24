// Based on Untitled (1977) by Agnes Martin
// https://www.artsy.net/artwork/agnes-martin-untitled-2025

int margin = 8;
int rect_w;
int rect_h;

void setup() {
  size(720, 720);
  rect_w = (width - margin*2) / 8;
  rect_h = (height - margin*2) / 36;
  background(255);
  stroke(#EEE1A1);
  for (int i = margin; i <= width - margin - rect_w; i += rect_w) {
    for (int j = margin; j <= height - margin - rect_h; j += rect_h) {
      if (j % 3 == 2) {
        fill(#FEF5B9);
      } else if (j % 3 == 0) {
        fill(#FFF2A6);
      } else if (j % 3 == 1) {
        fill(#FDF1BB);
      }
      rect(i, j, rect_w, rect_h);
    }
  }
}
