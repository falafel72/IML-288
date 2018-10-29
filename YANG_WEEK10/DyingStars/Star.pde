public class Star {
  static final float diam_upper = 6.0;
  static final float diam_lower = 1.0;
  
  float x, y;
  float diam;
  float alpha;
  float die_rate;

  Star() {
    x = random(width);
    y = random(height);
    diam = random(diam_lower, diam_upper);
    alpha = random(255);

    die_rate = diam * 0.05;
  }

  public void die() {
    if (alpha >= 5) {
      fill(255, alpha - 5);
      ellipse(x, y, diam + 5, diam + 5);
    }
    fill(255, alpha);
    ellipse(x, y, diam, diam);
    alpha -= die_rate;
  }

  public float getAlpha() {
    return alpha;
  }
}
