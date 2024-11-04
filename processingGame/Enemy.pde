class Enemy {
  float x;
  float y;
  int velocity;
  int healthTotal;
  float healthLeft;
  int fireCoolingTime;
  ArrayList<EnemyBullet> thisEnemyBullets; 
  boolean hideThis; //hide it if this is true.
  int radius, scoreBonus;
  int subtractFromHealth;
  int[] rgb;
  float healthMultiplier; //for graphics showing the health bar.
  int[] offsetHealthBar;
  
  Enemy(float x, int velocity, int healthTotal, int radius, int subtractFromHealth, float healthMultiplier, int scoreBonus) {
    this.healthMultiplier = healthMultiplier;
    this.subtractFromHealth = subtractFromHealth;
    this.radius = radius;
    thisEnemyBullets = new ArrayList<EnemyBullet>();
    this.velocity = velocity;
    hideThis = false;
    this.healthTotal = healthTotal;
    healthLeft = healthTotal;
    fireCoolingTime = 50;
    this.scoreBonus = scoreBonus;
    this.x = x; //IDK IF I NEED TO HAVE THIS
    y = 20; //put it at the top of the screen.
  }
  
  int getScoreBonus() {
    return scoreBonus;
  }
  
  void setRGB(int[] rgb) {
    this.rgb = rgb;
  }
  
  void setOffsetHealthBar(int[] healthBar) {
    offsetHealthBar = healthBar;
  }
  
  boolean isHidden() {
    return hideThis;
  }
  
  boolean checkCollision(myBullet bullet) {
    if(hideThis) {
      return false; //no collision if it has disappeared.
    }
    float minDistance = radius + 10; //the radius of this StandardEnemy + 10 for the offset (I create the ellipse on y-20).
    //I also subtracted by 10 from the 20 because it looks better.
    float xDiff = Math.abs(x-bullet.getCoord()[0]);
    float yDiff = Math.abs(y-bullet.getCoord()[1]);
    
    if(xDiff < minDistance && yDiff < minDistance) {
      healthLeft-=subtractFromHealth; //if it was hit, decrease the health by whatever.
      return true; //true, there was a collision
    }
    return false; //no collision
  }
  
  float getHealthLeft() {
    return healthLeft;
  }
  
  ArrayList<EnemyBullet> getBulletArr() {
    return thisEnemyBullets;
  }
  
  void hide() {
    hideThis = true;
  }
  
  void update(Player player) { //TODO: GENERALIZE THIS.
    if(hideThis) { //I shouldn't care about this Enemy.
      showThisEnemyBullets(player); //I should still show the bullets.
      return;
    }
    strokeWeight(4);
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y-20, radius*2, radius*2);
    fill(0);
    rect(x+offsetHealthBar[0], y+offsetHealthBar[1], healthTotal*healthMultiplier, 20); //health rectangle total.
    fill(rgb[0], rgb[1], rgb[2]); //health bar
    rect((float)(x+offsetHealthBar[0]), (float)(y+offsetHealthBar[1]), healthLeft*healthMultiplier, (float)(20)); //health rectangle left
    
    fireCoolingTime++;
    if(velocity/y >= 0.5) { //only add to y if the rate increase is > 0.5
      y+=velocity/y;
    }
    
    fireBullets();
    showThisEnemyBullets(player);
  }
  
  boolean shouldBeKilled() { //because if I just check if bullet size = 0, it will delete as soon as it gets onscreen.
    return (thisEnemyBullets.size() == 0) && hideThis;
  }
  
  void fireBullets() {
    //to be overridden
  }
  
  void showThisEnemyBullets(Player player) {
    Iterator<EnemyBullet> iterBullets = thisEnemyBullets.iterator();
    while(iterBullets.hasNext()) {
      EnemyBullet currBullet = iterBullets.next();
      currBullet.update();
      currBullet.show();
      if(!currBullet.onScreen()) { //if it is offscreen, destroy it.
        iterBullets.remove();
      }
      if(currBullet.checkCollision(player)) {
        iterBullets.remove();
        player.gotHit();
      }
    }
  }
  
}
