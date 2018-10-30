class PowerUp {
  PImage icon_sheet;
  PImage[][] icons = new PImage[4][2];
  PImage lengthen1, lengthen2;
  PImage shorten1, shorten2;
  PImage accel1, accel2;
  PImage decel1, decel2;
  // TO-DO: star powerups that paddles can collect for points
  //PImage star, star3, star2, star1;
  int icon_w = 50;

  float x, y;
  // Types: lengthen, shorten, accel, decel, star
  int type;
  int player;

  PowerUp() {
    icon_sheet = loadImage("icon_sheet.png");
    icons[0][0] = icon_sheet.get(0, 0, icon_w, icon_w);
    icons[0][1] = icon_sheet.get(icon_w, 0, icon_w, icon_w);
    icons[1][0] = icon_sheet.get(icon_w*2, 0, icon_w, icon_w);
    icons[1][1] = icon_sheet.get(icon_w*3, 0, icon_w, icon_w);
    icons[2][0] = icon_sheet.get(0, icon_w, icon_w, icon_w);
    icons[2][1] = icon_sheet.get(icon_w, icon_w, icon_w, icon_w);
    icons[3][0] = icon_sheet.get(icon_w*2, icon_w, icon_w, icon_w);
    icons[3][1] = icon_sheet.get(icon_w*3, icon_w, icon_w, icon_w);
  }

  public void newPowerUp() {
    type = int(random(4));
    player = int(random(2));
    x = random(40.0, width - 40.0);
    y = random(height);
    powerup_exists = true;
  }

  public void display() {
    image(icons[type][player], x, y);
  }

  public void checkContact() {
    if (ball.getX() > x - icon_w/2 - 15 && ball.getX() < x + icon_w/2 + 15 &&
      ball.getY() > y - icon_w/2 - 15 && ball.getY() < y + icon_w/2 + 15) {
      println("contact");
      powerup_exists = false;
      if (type == 0 && player == 0) {
        paddle1.makeLonger();
      } else if (type == 0 && player == 1) {
        paddle2.makeLonger();
      } else if (type == 1 && player == 0) {
        paddle1.makeShorter();
      } else if (type == 1 && player == 1) {
        paddle2.makeShorter();
      } else if (type == 2 && player == 0) {
        paddle1.makeQuicker();
      } else if (type == 2 && player == 1) {
        paddle2.makeQuicker();
      } else if (type == 3 && player == 0) {
        paddle1.makeSlower();
      } else if (type == 3 && player == 1) {
        paddle2.makeSlower();
      }
    }
  }
}
