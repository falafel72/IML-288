// Modified to blend two images + pixel sort combined result

/*

 ASDF Pixel Sort
 Kim Asendorf | 2010 | kimasendorf.com
 
 sorting modes
 
 0 = black
 1 = brightness
 2 = white
 
 */

int mode = 1;

// image path is relative to sketch directory
PImage img1;
String img1Name = "man";
String img1Type = "jpg";
PImage img2;
String img2Name = "forest";
String img2Type = "jpg";
PImage combined;

int loops = 10;

// threshold values to determine sorting start and end pixels
int blackValue = -16000000;
int brightnessValue = 60;
int whiteValue = -13000000;

int row = 0;
int column = 0;

boolean saved = false;

void setup() {
  size(1280, 854);
  blendMode(MULTIPLY);
  img1 = loadImage(img1Name + "." + img1Type);
  img2 = loadImage(img2Name + "." + img2Type);
  image(img1, 0, 0);
  image(img2, 0, 0);
  combined = get(0, 0, img1.width, img1.height);
  background(255);
  image(combined, 0, 0);
}

void draw() {
  
  // loop through columns
  while(column < combined.width-1) {
    println("Sorting Column " + column);
    combined.loadPixels(); 
    sortColumn();
    column++;
    combined.updatePixels();
  }
  
  // loop through rows
  while(row < combined.height-1) {
    println("Sorting Row " + column);
    combined.loadPixels(); 
    sortRow();
    row++;
    combined.updatePixels();
  }
  
  // load updated image onto surface and scale to fit the display width,height
  background(255);
  image(combined, 0, 0, width, height);
  
  if(!saved && frameCount >= loops) {
    
  // save combined
    combined.save(img1Name + "+" + img2Name + "_" + mode + ".jpg");
  
    saved = true;
    println("Saved "+frameCount+" Frame(s)");
    
    // exiting here can interrupt file save, wait for user to trigger exit
    println("Click or press any key to exit...");
  }
}

void keyPressed() {
  if(saved)
  {
    System.exit(0);
  }
}

void mouseClicked() {
  if(saved)
  {
    System.exit(0);
  }
}

void sortRow() {
  // current row
  int y = row;
  
  // where to start sorting
  int x = 0;
  
  // where to stop sorting
  int xend = 0;
  
  while(xend < combined.width-1) {
    switch(mode) {
      case 0:
        x = getFirstNotBlackX(x, y);
        xend = getNextBlackX(x, y);
        break;
      case 1:
        x = getFirstBrightX(x, y);
        xend = getNextDarkX(x, y);
        break;
      case 2:
        x = getFirstNotWhiteX(x, y);
        xend = getNextWhiteX(x, y);
        break;
      default:
        break;
    }
    
    if(x < 0) break;
    
    int sortLength = xend-x;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = combined.pixels[x + i + y * combined.width];
    }
    
    sorted = sort(unsorted);
    
    for(int i=0; i<sortLength; i++) {
      combined.pixels[x + i + y * combined.width] = sorted[i];      
    }
    
    x = xend+1;
  }
}


void sortColumn() {
  // current column
  int x = column;
  
  // where to start sorting
  int y = 0;
  
  // where to stop sorting
  int yend = 0;
  
  while(yend < combined.height-1) {
    switch(mode) {
      case 0:
        y = getFirstNotBlackY(x, y);
        yend = getNextBlackY(x, y);
        break;
      case 1:
        y = getFirstBrightY(x, y);
        yend = getNextDarkY(x, y);
        break;
      case 2:
        y = getFirstNotWhiteY(x, y);
        yend = getNextWhiteY(x, y);
        break;
      default:
        break;
    }
    
    if(y < 0) break;
    
    int sortLength = yend-y;
    
    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];
    
    for(int i=0; i<sortLength; i++) {
      unsorted[i] = combined.pixels[x + (y+i) * combined.width];
    }
    
    sorted = sort(unsorted);
    
    for(int i=0; i<sortLength; i++) {
      combined.pixels[x + (y+i) * combined.width] = sorted[i];
    }
    
    y = yend+1;
  }
}


// black x
int getFirstNotBlackX(int x, int y) {
  
  while(combined.pixels[x + y * combined.width] < blackValue) {
    x++;
    if(x >= combined.width) 
      return -1;
  }
  
  return x;
}

int getNextBlackX(int x, int y) {
  x++;
  
  while(combined.pixels[x + y * combined.width] > blackValue) {
    x++;
    if(x >= combined.width) 
      return combined.width-1;
  }
  
  return x-1;
}

// brightness x
int getFirstBrightX(int x, int y) {
  
  while(brightness(combined.pixels[x + y * combined.width]) < brightnessValue) {
    x++;
    if(x >= combined.width)
      return -1;
  }
  
  return x;
}

int getNextDarkX(int _x, int _y) {
  int x = _x+1;
  int y = _y;
  
  while(brightness(combined.pixels[x + y * combined.width]) > brightnessValue) {
    x++;
    if(x >= combined.width) return combined.width-1;
  }
  return x-1;
}

// white x
int getFirstNotWhiteX(int x, int y) {

  while(combined.pixels[x + y * combined.width] > whiteValue) {
    x++;
    if(x >= combined.width) 
      return -1;
  }
  return x;
}

int getNextWhiteX(int x, int y) {
  x++;

  while(combined.pixels[x + y * combined.width] < whiteValue) {
    x++;
    if(x >= combined.width) 
      return combined.width-1;
  }
  return x-1;
}


// black y
int getFirstNotBlackY(int x, int y) {

  if(y < combined.height) {
    while(combined.pixels[x + y * combined.width] < blackValue) {
      y++;
      if(y >= combined.height)
        return -1;
    }
  }
  
  return y;
}

int getNextBlackY(int x, int y) {
  y++;

  if(y < combined.height) {
    while(combined.pixels[x + y * combined.width] > blackValue) {
      y++;
      if(y >= combined.height)
        return combined.height-1;
    }
  }
  
  return y-1;
}

// brightness y
int getFirstBrightY(int x, int y) {

  if(y < combined.height) {
    while(brightness(combined.pixels[x + y * combined.width]) < brightnessValue) {
      y++;
      if(y >= combined.height)
        return -1;
    }
  }
  
  return y;
}

int getNextDarkY(int x, int y) {
  y++;

  if(y < combined.height) {
    while(brightness(combined.pixels[x + y * combined.width]) > brightnessValue) {
      y++;
      if(y >= combined.height)
        return combined.height-1;
    }
  }
  return y-1;
}

// white y
int getFirstNotWhiteY(int x, int y) {

  if(y < combined.height) {
    while(combined.pixels[x + y * combined.width] > whiteValue) {
      y++;
      if(y >= combined.height)
        return -1;
    }
  }
  
  return y;
}

int getNextWhiteY(int x, int y) {
  y++;
  
  if(y < combined.height) {
    while(combined.pixels[x + y * combined.width] < whiteValue) {
      y++;
      if(y >= combined.height) 
        return combined.height-1;
    }
  }
  
  return y-1;
}
