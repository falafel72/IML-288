ArrayList<Star> stars = new ArrayList<Star>();
float diam_upper = 10.0;
float diam_lower = 2.0;

void setup() {
  size(1280, 720);
  noStroke();
  fill(255);
  for (int i = 0; i < 200; i++) {
    stars.add(new Star(random(width), random(height),
      random(diam_lower, diam_upper), random(255)));    
  }
}

void draw() {
  //filter(BLUR, 5);
  background(0);
  for (int i = 0; i < stars.size(); i++) {
    stars.get(i).die();
    if (stars.get(i).getAlpha() <= 0) {
      stars.remove(i);
      i--;
      stars.add(new Star(random(width), random(height),
        random(diam_lower, diam_upper), random(255)));
    }
  }
}

class Star {
  float x, y;
  float diam;
  float alpha;
  float die_rate;
  
  Star(float x, float y, float diam, float alpha) {
    this.x = x;
    this.y = y;
    this.diam = diam;
    this.alpha = alpha;
    
    die_rate = diam * 0.05;
  }
  
  public void die() {
    fill(255, alpha);
    ellipse(x, y, diam, diam);
    alpha -= die_rate;
  }
  
  public float getAlpha() {
    return alpha;
  }
}
