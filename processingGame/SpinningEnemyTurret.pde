class SpinningEnemyTurret extends Enemy {
 int fireCoolingTime;
 double velocity;
 float x, y, angle;
 double fireBulletCnt;
 boolean isHidden;
  
  SpinningEnemyTurret(float x, float y, angle) {
    super(x, 10, 1000, 40, 1, 0.04, 50); //velocity = 10, health = 1000, radius = 40, subtracthealth = 10, multiplier = 0.04, scoreBonus = 50.
    int[] rgb = {186, 112, 156};
    setRGB(rgb);
    int[] offsetHealthBar = {-20, -8};
    setOffsetHealthBar(offsetHealthBar);
    fireCoolingTime = 0;
    this.fireBulletCnt = 140;
    this.angle = angle;
    this.x = x;
    this.y = y;
    this.velocity = 10;
    isHidden = false;
  }
  
  void subtractFromHealth() {
    healthLeft-=19;
  }
  
  void setBulletArr(ArrayList<EnemyBullet> a) {
    thisEnemyBullets = a;
  }

  boolean removeThis() {
    if(isHidden && (thisEnemyBullets.size() == 0)) {
       return true;
    }
    return false;
  }
  
  void update(Player player) {
    if(hideThis) { //I shouldn't care about this Enemy.
      showThisEnemyBullets(player); //I should still show the bullets.
      isHidden = true;
      return;
    }

    if(shouldBounceHorizontal()) {
      angle = 180-angle;
    }
    if(shouldBounceVertical()) {
      angle = 90+((Math.abs(angle)%360)-90);
    }
    
    if(healthLeft <= 0) { //idkWHERE DOES IT CALL HIDE ON THIS
      hide();
      isHidden = true;
    }

    y+=velocity*Math.sin(radians(angle)); //calculating difference for where to draw the circle
    x+=velocity*Math.cos(radians(angle));
    

    if(velocity > 0) { //checking to stop decreasing velocity
      velocity-=0.1;
    }
    healthLeft-=1; //subtract from health every frame

    fireBulletCnt+=1;
    
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y, radius*2, radius*2);
    fill(0);
    rect(x+offsetHealthBar[0], y+offsetHealthBar[1], healthTotal*healthMultiplier, 20); //health rectangle total.
    fill(rgb[0], rgb[1], rgb[2]); //health bar
    rect(x+offsetHealthBar[0], y+offsetHealthBar[1], healthLeft*healthMultiplier, (float)(20)); //health rectangle left
    
    
    if(fireBulletCnt%4 == 0) { //fire bullets every 4 frames
      fireBullets();
    }
    showThisEnemyBullets(player);
  }

  boolean shouldBounceHorizontal() {
    if(x <= 10 || x >= width-10) { //out of bounds
      return true;
    }
    return false;
  }
  boolean shouldBounceVertical() {
    if(y <= 10) { //out of bounds
      return true;
    }
    return false;
  }

  float[] getCoord() {
    return [x,y];
  }
  
  void fireBullets() {
    float angle = (((float)fireBulletCnt/30)*19)%360; //fire in a circle. /30 = slowly.
    StandardEnemyBullet newBullet = new StandardEnemyBullet(x, y, angle);
    thisEnemyBullets.add(newBullet);

    angle = angle+180; //fire in a circle
    StandardEnemyBullet newBullet = new StandardEnemyBullet(x, y, angle);
    thisEnemyBullets.add(newBullet);

  }
  
}
