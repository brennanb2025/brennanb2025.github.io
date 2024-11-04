class CircleEnemy extends Enemy {
  int fireCoolingTime;
  CircleEnemyTurret[] turrets;
  
  CircleEnemy(float x) {
    super(x, 100, 8000, 80, 10, 0.0125, 200); //velocity = 100, health = 9000, radius = 80, subtracthealth = 10, multiplier = 0.0111, scoreBonus = 200.
    int[] rgb = {24, 76, 114};
    setRGB(rgb);
    int[] offsetHealthBar = {-50, -8};
    setOffsetHealthBar(offsetHealthBar);
    fireCoolingTime = 0;
    turrets = new CircleEnemyTurret[8];
  }
  
  void update(Player player) { //I have to override this whole thing to make fireBullets take a Player.
    if(hideThis) { //I shouldn't care about this Enemy.
      showThisTurrets(); //I should still show the turrets.
      return;
    }
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y, radius*2, radius*2);
    fill(0);
    rect(x+offsetHealthBar[0], y+offsetHealthBar[1], healthTotal*healthMultiplier, 20); //health rectangle total.
    fill(rgb[0], rgb[1], rgb[2]); //health bar
    rect((float)(x+offsetHealthBar[0]), (float)(y+offsetHealthBar[1]), healthLeft*healthMultiplier, (float)(20)); //health rectangle left
    
    if(1.5*velocity/y >= 0.6) { //only add to y if the rate increase is > 0.5
      y+=1.5*velocity/y;
    }
    
    boolean allDown = true;
    for(int i = 0; i < turrets.length; i++) {
      if(turrets[i] != null) {
        if(turrets[i].getHealthLeft() > 0) { 
          allDown = false;
        }
      }
    }
    if(fireCoolingTime>=210 && allDown) {//if all the turrets are down
      spawnTurrets();
    }
    fireCoolingTime++;
    
    showThisTurrets();
  }
  
  void spawnTurrets() {
    
    for(int j = 0; j < 4; j++) {
      if(turrets[j] != null && turrets[j].getBulletArr().size() > 0) {
        CircleEnemyTurret temp = new CircleEnemyTurret(0,0,"left"); //it doesn't matter
        temp.setBulletArr(turrets[j].getBulletArr());
        turrets[j+4] = temp;
      }
    }
    
    CircleEnemyTurret t = new CircleEnemyTurret(x, y, "left");
    turrets[0] = t;
  
    t = new CircleEnemyTurret(x, y, "right");
    turrets[1] = t;
    
    t = new CircleEnemyTurret(x, y, "up");
    turrets[2] = t;
    
    t = new CircleEnemyTurret(x, y, "down");
    turrets[3] = t;
  }
  
  void showThisTurrets() {
    for(int i = 0; i < turrets.length; i++) {
      if(turrets[i] != null) { //the turret is not dead.
        turrets[i].update(player, x, y);
      }
    }
  }
  
  boolean shouldBeKilled() { //TODO: FIX THIS
    boolean[] allBulletsGone = {false, false, false, false};
    for(int i = 0; i < 4; i++) {
      if(turrets[i] != null) {
        if(turrets[i].getBulletArr().size() == 0) {
          allBulletsGone[i] = true;
        }
      } else {allBulletsGone[i] = true;}
    }
    boolean rtn = true;
    for(int j = 0; j < 4; j++) {
      if(!allBulletsGone[j]) {
        rtn = false;
      }
    }
    return hideThis && rtn;
  }
  
  boolean checkCollision(myBullet bullet) { //I need to change this to check the turrets too.
    float minDistance = 0;
    float xDiff = 0;
    float yDiff = 0;
    
    if(!hideThis) {
      minDistance = radius + 10; //the radius of this StandardEnemy + 10 for the offset (I create the ellipse on y-20).
      //I also subtracted by 10 from the 20 because it looks better.
      xDiff = Math.abs(x-bullet.getCoord()[0]);
      yDiff = Math.abs(y-bullet.getCoord()[1]);
      
      if(xDiff < minDistance && yDiff < minDistance) {
        healthLeft-=subtractFromHealth; //if it was hit, decrease the health by whatever.
        return true; //true, there was a collision
      }
    }
    
    for(int i = 0; i < turrets.length; i++) {
      if(turrets[i] != null) {
        if(turrets[i].getHealthLeft() > 0) { //check if 
          minDistance = 50; //the radius of this circleTurret (40) + 10 for the offset
          xDiff = Math.abs(turrets[i].getCoord()[0]-bullet.getCoord()[0]);
          yDiff = Math.abs(turrets[i].getCoord()[1]-bullet.getCoord()[1]);
          
          if(xDiff < minDistance && yDiff < minDistance) {
            turrets[i].subtractFromHealth();
            return true; //true, there was a collision
          }
        }
      }
    }
    
    return false; //no collision
  }
  
}
