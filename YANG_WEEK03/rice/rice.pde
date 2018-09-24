// https://www.matthewmarks.com/new-york/exhibitions/2015-09-11_anne-truitt-in-japan/works-in-exhibition/#/images/5/

int margin = 20;
int padding = 5;
int[][] border1 = {{margin, 80},
                   {120, 60},
                   {250, 65},
                   {350, margin+30},
                   {width-margin, margin+30}};
int[][] border2 = {{margin, height-margin},
                   {100, 300},
                   {420, 80},
                   {width-margin, 250}};

size(540, 720);

// red
fill(#B64240);
noStroke();
beginShape();
vertex(margin, margin);
vertex(width-margin, margin);
vertex(border1[border1.length-1][0], border1[border1.length-1][1]);
for (int i = border1.length-1; i >= 0; i--) {
  curveVertex(border1[i][0], border1[i][1]);
}
curveVertex(border1[1][0], border1[1][1]);
vertex(border1[0][0], border1[0][1]);
endShape(CLOSE);

// pink
fill(#B14677);
stroke(#BB4C46);
strokeWeight(3);
beginShape();
curveVertex(border1[0][0], border1[0][1]);
curveVertex(border1[0][0], border1[0][1]);
for (int i = 1; i < border1.length; i++) {
  curveVertex(border1[i][0], border1[i][1]);
}
curveVertex(border1[border1.length-1][0], border1[border1.length-1][1]);
vertex(width-margin, 250);
vertex(border2[3][0], border2[3][1]);
bezierVertex(border2[2][0], border2[2][1],
             border2[1][0], border2[1][1],
             border2[0][0], border2[0][1]);
vertex(border1[0][0], border1[0][1]);
endShape(CLOSE);

// purple
fill(#8F5283);
stroke(#755289);
strokeWeight(8);
beginShape();
vertex(border2[0][0], border2[0][1]);
bezierVertex(border2[1][0], border2[1][1],
             border2[2][0], border2[2][1],
             border2[3][0], border2[3][1]);
vertex(width-margin, height-margin);
vertex(margin, height-margin);
endShape();

// white
fill(255);
noStroke();
beginShape();
vertex(0, 0);
vertex(width, 0);
vertex(width, height);
vertex(0, height);
beginContour();
vertex(margin+padding, margin+padding);
vertex(margin+padding, height-margin-padding);
vertex(width-margin-padding, height-margin-padding);
vertex(width-margin-padding, margin+padding);
endContour();
endShape(CLOSE);
