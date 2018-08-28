size(720, 720);
background(255);
//stroke(255);
//strokeWeight(5);
strokeCap(ROUND);
strokeJoin(ROUND);
float[][] curvePoints = new float[4][2];
int margin = 50;
color[] colors = {color(255, 0, 0), color(255, 255, 0), color(0, 0, 255)};
for (int i = 0; i < 10; i++) {
  for (int j = 0; j < 4; j++) {
    curvePoints[j][0] = random(margin, width-margin);
    curvePoints[j][1] = random(margin, height-margin);
  }
  fill(colors[int(random(3))]);
  beginShape();
  curveVertex(curvePoints[0][0], curvePoints[0][1]);
  curveVertex(curvePoints[0][0], curvePoints[0][1]);
  curveVertex(curvePoints[1][0], curvePoints[1][1]);
  curveVertex(curvePoints[2][0], curvePoints[2][1]);
  curveVertex(curvePoints[3][0], curvePoints[3][1]);
  curveVertex(curvePoints[3][0], curvePoints[3][1]);
  /*curveVertex(curvePoints[1][0], curvePoints[1][1],
         curvePoints[2][0], curvePoints[2][1],
         curvePoints[3][0], curvePoints[3][1]);*/
  endShape(CLOSE);
}
