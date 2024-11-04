class ComplexEnemy extends Enemy {
int fireCoolingTime;
  
  ComplexEnemy(float x) {
    super(x, 100, 8000, 80, 10, 0.0125, 200); //velocity = 100, health = 9000, radius = 80, subtracthealth = 10, multiplier = 0.0111, scoreBonus = 10.
    int[] rgb = {104, 216, 192};
    setRGB(rgb);
    int[] offsetHealthBar = {-50, -28};
    setOffsetHealthBar(offsetHealthBar);
    fireCoolingTime = 100;
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
    if(velocity/y >= 0.5) { //only add to y if the rate increase is > 0.5
      y+=velocity/y;
    }
    
    fireBullets(player);
    showThisEnemyBullets(player);
  }
  
  void fireBullets(Player player) {
    if(fireCoolingTime >= 200) { //fire every 200 frames
      int rand = ((int)random(1, 19))*9; //gives me a random number between 1 and 18. (not including 19, so it floors to 18 at max.)
      //idk why 0 and 18 don't work.
      for(int i = 0; i <= 180; i+=9) { //gives me 0, 5, 10, ... 180; 
        if(rand != i) { //this should leave one of the spots open.
          double xVal = (player.getCoord()[0]) + 90*Math.cos(radians(i*2)); //distance away from the player.
          double yVal = (player.getCoord()[1]) + 90*Math.sin(radians(i*2));
          ComplexEnemyBullet newBullet = new ComplexEnemyBullet((float)xVal, (float)yVal, (float)i*2);
          thisEnemyBullets.add(newBullet);
        }
      }
      fireCoolingTime = 0;
    }
  }
  
  /*void showThisEnemyBullets(Player player) { //overriding this from Enemy. I might need to do this since the bullet type is different. They are triangles.
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
