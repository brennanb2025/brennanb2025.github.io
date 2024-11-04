class BouncingEnemy extends Enemy {
  int fireBulletsCnt;
  boolean shouldFireBullets;
  boolean shouldGoDown;
  boolean shouldGoRight;
  
  BouncingEnemy(float x) {
    super(x, 200, 6000, 70, 10, 0.017, 10); //velocity = 200, health = 100, radius = 70, subtracthealth = 10, multiplier = 0.6 scoreBonus = 10.
    int[] rgb = {55, 145, 14};
    setRGB(rgb);
    int[] offsetHealthBar = {-50, -10};
    setOffsetHealthBar(offsetHealthBar);
    fireBulletsCnt = 0;
    shouldFireBullets = false;
    shouldGoDown = true;
    shouldGoRight = true;
    speedMultiplier = 2;
  }
  
  void update(Player player) { //I have to override this whole thing to make fireBullets take a Player.
    if(hideThis) { //I shouldn't care about this Enemy.
      showThisEnemyBullets(player); //I should still show the bullets.
      return;
    }
    
    if(shouldGoDown) {
      y+=2;
    }
    else { //stopping when should fire bullets
      if(shouldGoRight) { //move to the top or far right position
        if(!shouldFireBullets) {
          if(x <= width/2) { //should go to the top.
            x+=3*speedMultiplier;
            y-=0.7*speedMultiplier;
          } else { //should go to far right.
            x+=3*speedMultiplier;
            y+=0.7*speedMultiplier;
            if(x >= width-150) { //should now go left
              shouldFireBullets = true; //it should fire just before it changes direction
              shouldGoRight = false;
            }
          }
        }
      } else {
        if(!shouldFireBullets) {
          if(x >= width/2) { //should go to the top.
            x-=3*speedMultiplier;
            y+=0.7*speedMultiplier;
          } else { //should go to far right.
            x-=3*speedMultiplier;
            y-=0.7*speedMultiplier;
            if(x <= 150) { //should now go right
              shouldFireBullets = true; //it should fire just before it changes direction
              shouldGoRight = true;
            }
          }
        }
      }
    }
    if(y >= 100) {
      shouldGoDown = false;
    }

    if(!shouldFireBullets && x >= (width/2)-1 && x <= (width/2)+1) {
      shouldFireBullets = true;
    }
    
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y, radius*2, radius*2);
    fill(0);
    rect(x+offsetHealthBar[0], y+offsetHealthBar[1], healthTotal*healthMultiplier, 20); //health rectangle total.
    fill(rgb[0], rgb[1], rgb[2]); //health bar
    rect((float)(x+offsetHealthBar[0]), (float)(y+offsetHealthBar[1]), healthLeft*healthMultiplier, (float)(20)); //health rectangle left
    
    
    if(!shouldGoDown && shouldFireBullets) {
      fireBullets();
    }
    
    showThisEnemyBullets(player);
  
  }
  
  void fireBullets() { //overriding this from Enemy
    if(shouldFireBullets) {
      fireBulletsCnt++;
    }
    if(fireBulletsCnt%10 == 0) { //fire every 10 frames
      for(int i = 1; i < 13; i++) { //This should fire 12 bullets
        float angle = 180-(i*(180.0/13.0)); //fire in an arc.
        BouncingEnemyBullet newBullet = new BouncingEnemyBullet(x, y, angle);
        thisEnemyBullets.add(newBullet);
      }
    }
    
    if(fireBulletsCnt >= 60) {
      fireBulletsCnt = 0;
      shouldFireBullets = false;
    }
  }
  
}
