Player player;
ArrayList<Enemy> enemies;
int enemiesDefeated;
int spawnAStandardEnemy;
int spawnRate;
int increaseSpawnRate;
int score;
boolean paused;
boolean start;
boolean isGameOver;
boolean[] levels;

void setup() {
  size(1000, 1000);
  enemiesDefeated = 0; 
  paused = false;
  spawnAStandardEnemy = 0; //Counter to tell if I should spawn a StandardEnemy
  increaseSpawnRate = 0;
  score = 0;
  spawnRate = 150; //this will decrease at a constant rate
  player = new Player(width/2, height*3/4);
  enemies = new ArrayList<Enemy>();
  player.show();
  start = true;
  isGameOver = false;
  levels = [false, false, false, false, false, false, false, false, false];
}

void draw() {

  if(player.getHealth() <= 0) {
    gameOver();
    return;
  }
  
  if(start) {
    mainScreen();
    return;
  }
  
  background(170, 224, 255);
  
  player.showBullets();
  textSize(20);
  fill(0);
  text("Lives left: " + player.getHealth(), 770, 30);
  text("Enemies defeated: " + enemiesDefeated, 770, 50);
  text("Score: " + score, 770, 70);
  text("Combo: " + player.getCombo(), 770, 90);
  
  if(paused) {
    textSize(70);
    text("PAUSED", width/2-120, 300);
    text("Click p again to resume", width/2-350, 400);
    textSize(40);
    text("Click enter to go back to the main menu.", width/2-350, height-height/4);
    return;
  }
  
  if(levels[0]) {
    wave0_all();
  } else if(levels[1]) {
    wave1_standard();
  } else if(levels[2]) {
    wave2_big();
  } else if(levels[3]) {
    wave3_2Big();
  } else if(levels[4]) {
    wave4_complex();
  } else if(levels[5]) {
    wave5_circle();
  } else if(levels[6]) {
    wave6_godKiana();
  } else if(levels[7]) {
    wave7_bouncing();
  } else if(levels[8]) {
    wave8_spinning();
  }

  
  player.update();

  ArrayList<myBullet> currBullets = player.getBullets();
  Iterator<Enemy> iter = enemies.iterator(); //Iterator bc I remove from the foreach loop during it.
  while(iter.hasNext()) {
    Enemy enemy = iter.next();
    
    boolean thisCollided = false; //all checking for collisions
    Iterator<myBullet> iterBullets = currBullets.iterator();
    int cnt = 0; //for deleting the bullet from the list of all of myBullets in player
    while(iterBullets.hasNext()) {
      myBullet currBullet = iterBullets.next();
      if(enemy.checkCollision(currBullet)) { //there was a collision btwn this enemy and the myBullet.
        player.removeBullet(cnt);
        thisCollided = true;
        break;
      }
      cnt++;
    } //check for collisions done
    
    if(thisCollided && enemy.getHealthLeft() <= 0 && !enemy.isHidden()) { //the enemy got destroyed. 
      player.addCombo();
      enemiesDefeated+=1;
      score+=enemy.getScoreBonus() + player.getCombo();
      enemy.hide();
    }
    if(enemy.shouldBeKilled()) { //If there aren't any bullets still on the screen from this enemy. KILL IT.
       iter.remove();
    }
    enemy.update(player);
  }
  
}

void wave0_all() {
  //enemy stuff. THIS IS THE LEVEL
  if(enemiesDefeated < 30) { //spawn 30 standard enemies
    wave1_standard();
  } else if (enemiesDefeated < 31) { //enemiesDefeated will be 30 now. Spawn a big enemy
    wave2_big();
  } else if (enemiesDefeated < 32) { //score will be 31 now. Spawn two big enemies
    wave3_2Big();
  } else if (enemiesDefeated < 34) { //spawn a complex enemy (surrounds you with bullets)
    wave4_complex();
  } else if(enemiesDefeated < 35) { //spawn a circle enemy with turrets
    wave5_circle();
  } else if(enemiesDefeated < 36) { //spawn a god kiana enemy
    wave6_godKiana();
  } else if(enemiesDefeated < 37) { //spawn a bouncing enemy whose bullets also bounce
    wave7_bouncing();
  } else if(enemiesDefeated < 38) { //spawn a spinning enemy
    wave8_spinning();
  }
}
void wave1_standard() {
  //enemy spawn rate
  if (enemiesDefeated+enemies.size() < 30) {
    if(spawnRate >= 30) { //stop increasing the spawn rate.
      increaseSpawnRate+=2;
      if(increaseSpawnRate >= 100) { //should decrease spawnRate every 300 frames
        spawnRate-=2;
        increaseSpawnRate = 0;
      }
    }
    spawnAStandardEnemy++; //should increase this every frame. 200 is when difficulty increases.
    if(spawnAStandardEnemy >= spawnRate) { //should increase spawns at a constant rate
      if(enemies.size() < 6) {
        enemies.add(new StandardEnemy((int)random(30, width-30)));
        spawnAStandardEnemy = 0;
      }
    }
  }
}
void wave2_big() {
  if(enemies.size() == 0) { //only spawn one of them.
    enemies.add(new BigEnemy(width/2, true));
  }
}
void wave3_2Big() {
  if(enemies.size() == 0) {
    enemies.add(new BigEnemy(80, true));
    enemies.add(new BigEnemy(width, false));
  }
}
void wave4_complex() {
  if(enemies.size() == 0) {
    enemies.add(new ComplexEnemy(width/2));
  }
}
void wave5_circle() {
  if(enemies.size() == 0) {
    enemies.add(new CircleEnemy(width/2));
  }
}
void wave6_godKiana() {
  if(enemies.size() == 0) {
    enemies.add(new GodKiana(width/2));
  }
}
void wave7_bouncing() {
  if(enemies.size() == 0) {
    enemies.add(new BouncingEnemy(width/2));
  }
}
void wave8_spinning() {
  if(enemies.size() == 0) {
    enemies.add(new SpinningEnemy(width/2));
  }
}


void gameOver() {
  isGameOver = true;
  background(7, 6, 38);
  textSize(100);
  fill(255);
  text("GAME OVER", width/2-300, height/2);
  textSize(40)
  text("Press enter to go back to the main screen", width/2-350, height/2+200)
}

void mainScreen() {
  background(255, 255, 255);
  textSize(70);
  text("Main Screen", width/2-230, height/5)
  textSize(40);
  fill(0);
  text("Type:\n0 for a full playthrough\n1 for 30 standard enemies\n2 for one big enemy\n3 for two big enemies\n4 for a surrounding enemy\n5 for a turret enemy\n6 for a summoning enemy\n7 for a bouncing enemy\n8 for a spinning enemy", width/2-300, height*2/5);
}


//keys pressed/released
void keyPressed() {
  if(paused || isGameOver) {
    if (key == '\n') {
      setup();
    }
  }
  if (key == 'w') {
    player.up(1);
  }
  if (key == 'a') {
    player.left(1);
  }
  if (key == 's') {
    player.down(1);
  }
  if (key == 'd') {
    player.right(1);
  }
  if (key == 'j') {
    player.limMvmt(2); //mvmt multiplier = 2
  }
  if (key == ' ') {
    player.space(1);
  }
  if (start) {
    if (key == '0') {
      start = false;
      levels[0] = true;
    }
    if (key == '1') {
      start = false;
      levels[1] = true;
    }
    if (key == '2') {
      start = false;
      levels[2] = true;
    }
    if (key == '3') {
      start = false;
      levels[3] = true;
    }
    if (key == '4') {
      start = false;
      levels[4] = true;
    }
    if (key == '5') {
      start = false;
      levels[5] = true;
    }
    if (key == '6') {
      start = false;
      levels[6] = true;
    }
    if (key == '7') {
      start = false;
      levels[7] = true;
    }
    if (key == '8') {
      start = false;
      levels[8] = true;
    }
  } else {
    if (key == 'p') {
      paused = !paused;
    }
  }
}
void keyReleased() {
  if (key == 'w') {
    player.up(0);
  }
  if (key == 's') {
    player.down(0);
  }
  if (key == 'a') {
    player.left(0);
  }
  if (key == 'd') {
    player.right(0);
  }
  if (key == 'j') {
    player.limMvmt(4.3); //set mvmt to *4
  }
  if (key == ' ') {
    player.space(0);
  }
}
