size(720, 720);
background(0);

int x_pos = width/6;
int y_pos = height/2;
int diameter = 50;

for (int i = 1; i <= 6; i += 2) {
  x_pos = width/6 * i;
  ellipse(x_pos, y_pos, diameter, diameter);
}
