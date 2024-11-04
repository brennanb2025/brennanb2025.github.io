class StandardEnemy extends Enemy {
  int fireBulletRate;
  
  StandardEnemy(float x) {
    super(x, 200, 100, 40, 10, 0.6, 10); //velocity = 200, health = 100, radius = 40, subtracthealth = 10, multiplier = 0.6 scoreBonus = 10.
    int[] rgb = {255, 161, 68};
    setRGB(rgb);
    int[] offsetHealthBar = {-30, -28};
    setOffsetHealthBar(offsetHealthBar);
    fireBulletRate = 100; //this is the # of frames that I have to pass to fire bullets.
  }
  
  ArrayList<EnemyBullet> getBulletArr() {
    return thisEnemyBullets;
  }
  
  void fireBullets() { //overriding this from Enemy
    if(fireCoolingTime >= fireBulletRate) { //fire bullets every time it passes fireBulletRate # of frames
      for(int i = 1; i < 10; i++) { //This should fire 9 bullets
        float angle = 180-(i*18); //fire in an arc.
        StandardEnemyBullet newBullet = new StandardEnemyBullet(x, y, angle); //set x,y velocity. Right now they are at 5.
        thisEnemyBullets.add(newBullet);
      }
      fireCoolingTime = 0;
    }
  }
  
}
