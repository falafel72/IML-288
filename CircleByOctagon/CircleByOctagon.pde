int layers = 8;
Line[][] lines;

void setup() {
  size(720, 720);
  
  lines = new Line[layers][];
  for (int i = 0; i < lines.length; i++) {
    lines[i] = new Line[int(pow(2, i+2))];
  }
  
  lines[0][0] = new Line(0, 0, width, 0);
  lines[0][1] = new Line(width, 0, width, height);
  lines[0][2] = new Line(width, height, 0, height);
  lines[0][3] = new Line(0, height, 0, 0);
  
  
  for (int i = 1; i < lines.length; i++) {
    for (int j = 0; j < lines[i].length; j += 2) {
      PVector start = lines[i - 1][j/2].getTwoThirds();
      PVector end;
      if (j == lines[i].length - 2) {
        end = lines[i - 1][0].getThird();
      } else {
        end = lines[i - 1][j/2 + 1].getThird();
      }
      lines[i][j] = new Line(start.x, start.y, end.x, end.y);
      if (j == lines[i].length - 2) {
        start = lines[i - 1][0].getThird();
        end = lines[i - 1][0].getTwoThirds();
      } else {
        start = lines[i - 1][j/2 + 1].getThird();
        end = lines[i - 1][j/2 + 1].getTwoThirds();
      }
      lines[i][j + 1] = new Line(start.x, start.y, end.x, end.y);
    }
  }
}

void draw() {
  background(255);
  for (int i = 0; i < lines.length; i++) {
    for (int j = 0; j < lines[i].length; j++) {
      lines[i][j].display();
    }
  }
}