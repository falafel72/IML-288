class Pie {
  float x, y;
  int line_count;
  float diam;
  float pie_offset = 0.0;
  
  Pie() {
    x = random(width);
    y = random(height);
    line_count = int(random(30.0, 100.0));
    diam = random(30.0, 100.0);
  }
  
  void update() {
    pie_offset += 0.1;
  }
  
  void display() {
    float line_offset = pie_offset;
    for (int i = 0; i < line_count; i++) {
      float rad = map(i, 0, line_count, 0, TWO_PI);
      float line_len = diam + map(noise(line_offset), 0, 1, diam*0.5, diam*1.5);
      line(x, y, x + cos(rad) * line_len, y + sin(rad) * line_len);
      line_offset += 0.2;
    }
  }
}
