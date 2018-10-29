public class Star {
  color[] colors = {#F13D53, #ED7045, #E7E6A1, #F2F1CE, #ECECEC, #B1BCF7, #B1BCF7};
  
  float x, y;
  float distance; // in light years
  float alpha;
  float mass; // in solar masses
  float diam;
  float surf_temp;
  
  float evolve_rate;
  
  float color_float;
  color color_fill;

  Star() {
    x = random(width);
    y = random(height);
    distance = random(4.24, 26.0);
    alpha = map(distance, 4.24, 26.0, 255.0, 2.0);
    mass = abs(randomGaussian() * 20 + 20);
    evolve_rate = 0.01 * mass;
  }

  public void evolve() {
    mass += evolve_rate;
    diam = map(mass, 15.0, 135.0, 1.0, 10.0);
    
    // https://astronomy.stackexchange.com/questions/13104/how-to-calculate-the-temperature-of-a-star
    surf_temp = 3000 * pow(mass, 0.54);
    if (surf_temp > 35000) {
      surf_temp = 35000;
    } else if (surf_temp < 3500) {
      surf_temp = 3500;
    }
    
    color_float = map(surf_temp, 3500, 50000, 0, 6);
    color_fill = lerpColor(colors[floor(color_float)], colors[ceil(color_float)], color_float/6);
  }

  public void display() {
    if (alpha >= 5) {
      fill(color_fill, alpha - 5);
      ellipse(x, y, diam + 5, diam + 5);
    }
    fill(color_fill, alpha);
    ellipse(x, y, diam, diam);
  }

  public float getDiam() {
    return diam;
  }
}
