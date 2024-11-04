class SpinningEnemy extends Enemy {
  int fireCoolingTime;
  
  SpinningEnemy(float x) {
    super(x, 100, 6000, 80, 10, 0.017, 200); //velocity = 100, health = 9000, radius = 80, subtracthealth = 10, multiplier = 0.0111, scoreBonus = 200.
    int[] rgb = {207, 182, 224};
    setRGB(rgb);
    int[] offsetHealthBar = {-50, -10};
    setOffsetHealthBar(offsetHealthBar);
    fireCoolingTime = 100;
    turretList = new ArrayList<SpinningEnemyTurret>();
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
    
    if(1.5*velocity/y >= 0.7) { //only add to y if the rate increase is > 0.7
      y+=1.5*velocity/y;
    }
    
    if(fireCoolingTime >= 250) { //fire a turret.
      spawnTurret(player);
      fireCoolingTime = 0;
    }
    
    fireCoolingTime++;
    
    showThisTurrets();
  }
  
  void spawnTurret(player) {
      float oppositeSide = player.getCoord()[1]-y;
      float adjacentSide = player.getCoord()[0]-x;
      float angleToPlayer = atan2(oppositeSide, adjacentSide)*180/PI;

      SpinningEnemyTurret spinEnemyTurr1 = new SpinningEnemyTurret(x, y, angleToPlayer+10); //make a new turret going towards player
      SpinningEnemyTurret spinEnemyTurr2 = new SpinningEnemyTurret(x, y, angleToPlayer-10); //make a new turret going towards player
      turretList.add(spinEnemyTurr1);
      turretList.add(spinEnemyTurr2);
  }
  
  void showThisTurrets() {
    for(int i = 0; i < turretList.size(); i++) {
      if(turretList.get(i).removeThis()) { //remove turret from list
        turretList.remove(i);
      }
      if(turretList.get(i) != null) { //the turret is not dead.
        turretList.get(i).update(player, x, y);
      }
    }
  }
  
  /*boolean shouldBeKilled() { //TODO: FIX THIS
    boolean[] allBulletsGone = {false, false, false, false};
    for(int i = 0; i < 4; i++) {
      if(turretList.get(i) != null) {
        if(turretList.get(i).getBulletArr().size() == 0) {
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
  }*/
  
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
    
    for(int i = 0; i < turretList.size(); i++) {
      turretLook = turretList.get(i);
      if(turretLook != null) {
        if(turretLook.getHealthLeft() > 0) { //check if 
          minDistance = 50; //the radius of this circleTurret (40) + 10 for the offset
          xDiff = Math.abs(turretLook.getCoord()[0]-bullet.getCoord()[0]);
          yDiff = Math.abs(turretLook.getCoord()[1]-bullet.getCoord()[1]);
          
          if(xDiff < minDistance && yDiff < minDistance) {
            turretLook.subtractFromHealth();
            return true; //true, there was a collision
          }
        }
      }
    }
    
    return false; //no collision
  }
  
}
