class BigEnemy extends Enemy {
  boolean moveRight;
  
  BigEnemy(float x, boolean moveRight) {
    super(x, 100, 5000, 80, 10, 0.018, 100); //velocity = 100, health = 5000, radius = 80, subtracthealth = 10, multiplier = 0.001, scoreBonus = 10.
    int[] rgb = {51, 191, 140};
    setRGB(rgb);
    int[] offsetHealthBar = {-50, -26}; //change this?????
    setOffsetHealthBar(offsetHealthBar);
    this.moveRight = moveRight;
  }
  
  void fireBullets() { //overriding this from Enemy
    addX();
    if(fireCoolingTime%5 == 0) { //fire in succession
      float angleDiff = 2*((float)fireCoolingTime/10); //gives me 0, 1, 2, 3, ... 10.
      float angle = 180-(angleDiff*18); //fire in an arc.
      StandardEnemyBullet newBullet = new StandardEnemyBullet(x, y, angle); //set x,y velocity. Right now they are at 5.
      thisEnemyBullets.add(newBullet);
    }
    if(fireCoolingTime >= 50) {fireCoolingTime = -5;}
  }
  void addX() {
    if(x <= 80) { //going to go out of bounds on the left side
      moveRight = true;
    }
    else if(x >= width-80) {
      moveRight = false;
    }
    if(moveRight) {
      x+=1+(Math.abs(width-x)/300); //for bouncing motion
    } else {
      x-=(1+(x/300));
    }
  }
  
  /*void showThisEnemyBullets(Player player) { //overriding this from Enemy
    Iterator<EnemyBullet> iterBullets = thisEnemyBullets.iterator();
    while(iterBullets.hasNext()) {
      EnemyBullet currBullet = iterBullets.next();
      currBullet.update();
      if(!currBullet.onScreen()) { //if it is offscreen, destroy it.
        iterBullets.remove();
      }
      if(currBullet.checkCollision(player)) {
        iterBullets.remove();
        player.gotHit();
      }
    }
  }*/
  
  
}
