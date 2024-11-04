class GodKiana extends Enemy {
  boolean goodToFire;
  float randX, randY, rand2X, rand2Y;
  int fireCoolingTime, fireCoolingTime2;
  boolean goRight;
  boolean goDown;
  float angleToPlayer;
  
  GodKiana(float x) {
    super(x, 0, 9000, 80, 10, 0.0111, 200); //velocity = 100, health = 9000, radius = 80, subtracthealth = 10, multiplier = 0.0111, scoreBonus = 10.
    int[] rgb = {255, 226, 12};
    setRGB(rgb);
    int[] offsetHealthBar = {-50, -28};
    setOffsetHealthBar(offsetHealthBar);
    fireCoolingTime = 0;
    goodToFire = true;
    randX = 0;
    randY = 0;
    rand2X = 0;
    rand2Y = 0;
    goRight = false;
    goDown = true;
    fireCoolingTime2 = -10;
    angleToPlayer = 0;
  }
  
  void update(Player player) { //I have to override this whole thing to make fireBullets take a Player.
    if(hideThis) { //I shouldn't care about this Enemy.
      showThisEnemyBullets(player); //I should still show the bullets.
      return;
    }
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y-20, radius*2, radius*2);
    fill(0);
    rect(x+offsetHealthBar[0], y+offsetHealthBar[1], healthTotal*healthMultiplier, 20); //health rectangle total.
    fill(rgb[0], rgb[1], rgb[2]); //health bar
    rect((float)(x+offsetHealthBar[0]), (float)(y+offsetHealthBar[1]), healthLeft*healthMultiplier, (float)(20)); //health rectangle left
    
    fireCoolingTime++;
    fireCoolingTime2++;
    
    if(goDown) {y+=2;}
    else {
      y = 40 * sin(x/30) + 200;
      if(goRight) {x+=3;}
      else {x-=3;}
      if(x <= 60) {goRight = true;}
      if(x >= width-60) {goRight = false;}
    }
    if(y > 200) {goDown = false;}
    
    /*if(fireCoolingTime2 >= 30) {
      fireBullets2();
    }*/
    
    fireBullets(player); //do it twice
    showThisEnemyBullets(player);
  }
  
  /*void fireBullets2() {
    if(fireCoolingTime%6 == 0) {
      
      for(int i = 12; i < 180; i+=12) {
        GodKianaBullet newBullet = new GodKianaBullet(x, y+40, radians(i), 5, 5);
        thisEnemyBullets.add(newBullet);
      
      }
      if(fireCoolingTime2 >= 50) {
        fireCoolingTime2 = 0;
      }
      
    }
    
  }*/
  
  void fireBullets(Player player) {
    if(fireCoolingTime >= 30) { //fire every 10 frames.
      if(goodToFire) { //so it doesn't make a new coordinate for the ellipse.
        randX = random(40,width/2);
        randY = random(40,100);
        rand2X = random(width/2,width-40);
        rand2Y = randY;
      }
      fill(0);
      ellipse(randX, randY, 40+120-fireCoolingTime, 40+120-fireCoolingTime);
      goodToFire = false; //make it not calculate the random numbers again.
      
      float xRandBullet = random(randX-35-(120-fireCoolingTime), randX+35-(120-fireCoolingTime))+70;
      //an x val inside the previously drawn ellipse.
      float yRandBullet = random(randY-35-(120-fireCoolingTime), randY+35-(120-fireCoolingTime))+70;
      
      float oppositeSide = player.getCoord()[1]-yRandBullet;
      float adjacentSide = player.getCoord()[0]-xRandBullet;
      float angleToPlayer = atan2(oppositeSide, adjacentSide);
      float randVel = random(8,11);
      
      GodKianaBullet newBullet = new GodKianaBullet(xRandBullet, yRandBullet, angleToPlayer, randVel, randVel);
      thisEnemyBullets.add(newBullet);
      
      //Make a second one.
      
      fill(0);
      ellipse(rand2X, rand2Y, 40+120-fireCoolingTime, 40+120-fireCoolingTime);
      goodToFire = false; //make it not calculate the random numbers again.
      
      xRandBullet = random(rand2X-35-(120-fireCoolingTime), rand2X+35-(120-fireCoolingTime))+70;
      //an x val inside the previously drawn ellipse.
      yRandBullet = random(rand2Y-35-(120-fireCoolingTime), rand2Y+35-(120-fireCoolingTime))+70;
      
      oppositeSide = player.getCoord()[1]-yRandBullet;
      adjacentSide = player.getCoord()[0]-xRandBullet;
      angleToPlayer = atan2(oppositeSide, adjacentSide);
      
      randVel = random(8,13);
      newBullet = new GodKianaBullet(xRandBullet, yRandBullet, angleToPlayer, randVel, randVel);
      thisEnemyBullets.add(newBullet);
      
      
      if(fireCoolingTime >= 70) {
        fireCoolingTime = 0;
        goodToFire = true;
      }
    }
  }
  
  
  
}
