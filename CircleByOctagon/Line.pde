public class Line {
  PVector start;
  PVector end;
  PVector dir;

  boolean animation = true;
  float frac_display;
  float frac_increment = 0.01;

  Line(float x1, float y1, float x2, float y2) {
    start = new PVector(x1, y1);
    end = new PVector(x2, y2);
    dir = PVector.sub(end, start);
  }

  public void display() {
    if (animation) {
      end = PVector.add(start, PVector.mult(dir, frac_display));
      if (frac_display < 1.0) {
        frac_display += frac_increment;
      } else if (frac_display > 1.0) {
        frac_display = 1.0;
      }
    }
    line(start.x, start.y, end.x, end.y);
  }

  PVector getThird() {
    return PVector.add(start, PVector.mult(dir, 0.29));
  }

  PVector getTwoThirds() {
    return PVector.add(start, PVector.mult(dir, 0.71));
  }
}
