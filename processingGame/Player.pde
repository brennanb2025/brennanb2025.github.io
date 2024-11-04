import java.util.Iterator;
class Player {
  float y, x;
  double[] keysPressed = {0,0,0,0,0,4.3}; //a = 0, w = 1, d = 2, s = 3, space = 4, j = 5
  ArrayList<myBullet> myBullets;
  int coolingTime;
  int healthLeft;
  int combo;
  int hitDownTime;
  boolean isInvinc;

  Player(int x, int y) {
    coolingTime = 3;
    healthLeft = 8; //The player has 10 lives to begin with.
    myBullets = new ArrayList<myBullet>();
    int combo = 0;
    this.x = x;
    this.y = y;
    hitDownTime = 200;
    isInvinc = false;
  }

  ArrayList<myBullet> getBullets() {
    return myBullets;
  }
  
  void removeBullet(int loc) {
    myBullets.remove(loc);
  }
  
  void showBullets() {
    Iterator<myBullet> iter = myBullets.iterator(); //Iterator bc I remove from the foreach loop during it.
    while(iter.hasNext()) { //I think its faster to do this + cnt than myBullet.get(i)
      myBullet bullet = iter.next();
      if(bullet.update()) {
        bullet.show();
      } else {
        iter.remove(); //remove it if it is out of bounds
      }
    }
  }
  
  void show() {
    strokeWeight(5);
    fill(227, 183, 255);
    ellipse(x, y, 40, 40); //the body
    strokeWeight(2);
    fill(170, 124, 255);
    ellipse(x, y, 10, 10); //the hitbox
    strokeWeight(4);
    line(x+20, y, x+20, y-10); //the guns on either side
    line(x-20, y, x-20, y-10);
  }
  
  void addCombo() {
    combo++;
  }
  int getCombo() {
    return combo;
  }
  
  int getHealth() {
    return healthLeft;
  }
  
  void gotHit() {
    if(!isInvinc) {
      combo = 0;
      healthLeft--;
      isInvinc = true;
    }
  }
  
  float[] getCoord() {
    float[] rtn = {x,y};
    return rtn;
  }
  
  void update() {
    
    if(isInvinc) { //hit negation if just got hit.
      if(hitDownTime <= 60 && (hitDownTime%10 == 0 || hitDownTime%10 == 1 || hitDownTime%10 == 2 || hitDownTime%10 == 3 || hitDownTime%10 == 4 || hitDownTime%10 == 5)) {
        stroke(132, 68, 86);
        fill(132, 68, 86);
      } else {
        stroke(255, 170, 194);
        fill(255, 170, 194);
      }
      
      ellipse(x, y, 60, 60); //make an ellipse to show that ur invinc
      hitDownTime--;
      if(hitDownTime <= 0) {
        isInvinc = false;
        hitDownTime = 130;
      }
      stroke(0);
    }
    
    coolingTime+=1; //add one every time a bullet should be fired. 
    x+= keysPressed[5] * (2*keysPressed[2] - 2*keysPressed[0]);
    y+= keysPressed[5] * (2*keysPressed[3] - 2*keysPressed[1]);
    
    if(x > width-20) {
      x = width-20;
    } else if(x < 20) {
      x = 20;
    }
    if(y > height-20) {
      y = height-20;
    } else if(y < 20) {
      y = 20;
    }
    
    fill(227, 183, 255);
    ellipse(x, y, 40, 40); //the body
    strokeWeight(2);
    fill(170, 124, 255);
    ellipse(x, y, 10, 10); //the hitbox
    strokeWeight(5);
    line(x+20, y, x+20, y-25);
    line(x-20, y, x-20, y-25); //the guns on the side
    
    if(keysPressed[4] == 1 && coolingTime >= 4) { //coolingTime before firing another bullet. Only fire bullet 1/3th of the time.
      myBullets.add(new myBullet((int)(x+20), (int)(y-10))); //make the bullets
      myBullets.add(new myBullet((int)(x-20), (int)(y-10)));
      coolingTime = 0; //reset cooling time
    }
    
  }
  
  
  //keys pressed/released
  void up(int state) {
    keysPressed[1] = state;
  }
  void down(int state) {
    keysPressed[3] = state;
  }
  void left(int state) {
    keysPressed[0] = state;
  }
  void right(int state) {
    keysPressed[2] = state;
  }
  void space(int state) {
    keysPressed[4] = state;
  }
  void limMvmt(double state) {
    keysPressed[5] = state;
  }
  
}
