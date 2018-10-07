PImage smile, think;
int grid_size = 50;

void setup() {
  size(1280, 720);
  smile = loadImage("data/smile.png");
  think = loadImage("data/think.png");
}

void draw() {
  int counter = 0;
  for (int x = 0; x < width; x += grid_size) {
    for (int y = 0; y < height; y += grid_size) {
      if (counter % 2 == 0) {
        image(smile, x, y, grid_size, grid_size);
      } else {
        image(think, x, y, grid_size, grid_size);
      }
      counter++;
    }
    //counter++;
  }
}
