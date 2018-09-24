size(1024, 720);
int rect_w = 200;
int rect_h = 50;

fill(#ffd8e4);
stroke(#ffbfd2);
strokeWeight(2);
rect(0, height-rect_h, rect_w, rect_h);
rect(rect_w*0.75, height-(rect_h*2), rect_w, rect_h);
rect(rect_w*1.50, height-(rect_h*3), rect_w, rect_h);
rect(rect_w*2.25, height-(rect_h*4), rect_w, rect_h);
