public class Star {
  static final float dist_lower = 4.24;
  static final float dist_upper = 26.0;
  static final float alpha_lower = 2.0;
  static final float alpha_upper = 255.0;
  static final float mass_lower = 15.0;
  static final float mass_upper = 135.0;
  static final float diam_lower = 1.0;
  static final float diam_upper = 10.0;
  static final float surf_temp_lower = 3500;
  static final float surf_temp_upper = 35000;
  color[] colors = {#F13D53, #ED7045, #E7E6A1, #F2F1CE, #ECECEC, #B1BCF7, #B1BCF7};

  float x, y;
  float dist; // in light years
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
    dist = random(dist_lower, dist_upper);
    alpha = map(dist, dist_lower, dist_upper, alpha_upper, alpha_lower);
    mass = abs(randomGaussian() * 20 + 20);
    evolve_rate = 0.01 * mass;
  }

  public void evolve() {
    mass += evolve_rate;
    diam = map(mass, mass_lower, mass_upper, diam_lower, diam_upper);

    // https://astronomy.stackexchange.com/questions/13104/how-to-calculate-the-temperature-of-a-star
    surf_temp = 3000 * pow(mass, 0.54);
    if (surf_temp > surf_temp_upper) {
      surf_temp = surf_temp_upper;
    } else if (surf_temp < surf_temp_lower) {
      surf_temp = surf_temp_lower;
    }

    color_float = map(surf_temp, surf_temp_lower, surf_temp_upper, 0, colors.length - 1);
    color_fill = lerpColor(colors[floor(color_float)], colors[ceil(color_float)], 
      color_float - floor(color_float));
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
