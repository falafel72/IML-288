Sun sun;
Earth earth;
Moon moon;

void setup() {
  size(1280, 720, P3D);
}

void draw() {
  background(#0F071A);
  lights();
  camera(mouseX, mouseY, (height/2)/tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  noStroke();
  pushMatrix();
  translate(width/3, height/3, -400);
  fill(#F6BB3E);
  sphere(200);
  popMatrix();
  pushMatrix();
  translate(width/2, height/2, 0);
  fill(#4E6941);
  sphere(100);
  popMatrix();
  pushMatrix();
  translate(width*2/3, height*2/3, 50);
  fill(255);
  sphere(50);
  popMatrix();
}

class CelestialBody {
  
}

class Sun extends CelestialBody {
  
}

class Earth extends CelestialBody {
  
}

class Moon extends CelestialBody {
  
}
