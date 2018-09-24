size(1024, 720);
float x;
float y;
float rad;

background(255);
colorMode(HSB, 255, 100, 100);
//fill(#FDD843);
for (int i = 0; i < 100; i++) {
  fill(random(0, 50), 60, 100);
  x = random(width);
  y = random(height);
  rad = random(50, 100);
  strokeWeight(2);
  ellipse(x, y, rad, rad);
  strokeWeight(2.5);
  point(x-rad*0.15, y-rad*0.15);
  point(x+rad*0.15, y-rad*0.15);
  strokeWeight(1.5);
  arc(x, y, rad*0.6, rad*0.6, 0, PI);
}
