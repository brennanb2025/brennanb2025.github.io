class CircleEnemyTurret extends Enemy {
 int fireCoolingTime;
 int goOutwardTime;
 String direction;
 int amtToRotate;
 int xDiff, yDiff;
 double fireBulletCnt;
 float homeX, homeY;
  
  CircleEnemyTurret(float x, float y, String direction) {
    super(x, 100, 1000, 40, 1, 0.04, 50); //velocity = 100, health = 1000, radius = 40, subtracthealth = 10, multiplier = 0.04, scoreBonus = 50.
    int[] rgb = {96, 102, 147};
    setRGB(rgb);
    int[] offsetHealthBar = {-20, -8};
    setOffsetHealthBar(offsetHealthBar);
    fireCoolingTime = 0;
    goOutwardTime = 0;
    this.direction = direction;
    amtToRotate = 0;
    xDiff = 0;
    yDiff = 0;
    this.fireBulletCnt = 0;
    homeX = 0;
    homeY = 0;
  }
  
  float[] getCoord() {
    return rotatePoint(homeX+xDiff, homeY+yDiff, homeX, homeY, radians(amtToRotate%360));
  }
  
  void subtractFromHealth() {
    healthLeft-=10;
  }
  
  void setBulletArr(ArrayList<EnemyBullet> a) {
    thisEnemyBullets = a;
  }
  
  void update(Player player, float homeX, float homeY) {
    if(hideThis) { //I shouldn't care about this Enemy.
      showThisEnemyBullets(player); //I should still show the bullets.
      return;
    }
    
    if(healthLeft <= 0) { //idkWHERE DOES IT CALL HIDE ON THIS
      hide();
    }
    
    this.homeX = homeX;
    this.homeY = homeY;
    amtToRotate+=1.5;
    fireBulletCnt++;
    
    float[] newPoint = rotatePoint(homeX+xDiff, homeY+yDiff, homeX, homeY, radians(amtToRotate%360));
    
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(newPoint[0], newPoint[1], radius*2, radius*2);
    fill(0);
    rect(newPoint[0]+offsetHealthBar[0], newPoint[1]+offsetHealthBar[1], healthTotal*healthMultiplier, 20); //health rectangle total.
    fill(rgb[0], rgb[1], rgb[2]); //health bar
    rect(newPoint[0]+offsetHealthBar[0], newPoint[1]+offsetHealthBar[1], healthLeft*healthMultiplier, (float)(20)); //health rectangle left
    
    if(goOutwardTime <= 70) {
      goOutwardTime++;
      if(direction.equals("left")) {
        x-=2;
        xDiff-=2;
      } else if(direction.equals("right")) {
        x+=2;
        xDiff+=2;
      } else if(direction.equals("up")) {
        y+=2;
        yDiff+=2;
      } else if(direction.equals("down")) {
        y-=2;
        yDiff-=2;
      }
    }
    if(getHealthLeft() <= 0) {
      hide();
    }
    
    if(fireBulletCnt%4 == 0) { //fire bullets every fourth frame
      fireBullets(homeX, homeY);
    }
    showThisEnemyBullets(player);
  }
  
  void fireBullets(float homeX, float homeY) {
    
    float angle = (((float)fireBulletCnt/7)*18)%360; //fire in a circle. /7 = slowly.
    float[] newPoint = rotatePoint(homeX+xDiff, homeY+yDiff, homeX, homeY, radians(amtToRotate%360));
    StandardEnemyBullet newBullet = new StandardEnemyBullet(newPoint[0], newPoint[1], angle);
    thisEnemyBullets.add(newBullet);
  }
  
  float[] rotatePoint(float x1, float y1, float xPiv, float yPiv, float angle) {
    float s = sin(angle);
    float c = cos(angle);
  
    // translate point back to origin:
    x1 -= xPiv;
    y1 -= yPiv;
  
    // rotate point
    float xnew = x1 * c - y1 * s;
    float ynew = x1 * s + y1 * c;
  
    // translate point back:
    x1 = xnew + xPiv;
    y1 = ynew + yPiv;
    float[] rtn = {x1,y1};
    return rtn;
  }
  
}
