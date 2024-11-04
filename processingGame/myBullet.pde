class myBullet {
  int x, y;
  
  myBullet(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void show() {
    strokeWeight(4);
    stroke(82, 30, 104);
    line(x,y,x,y-35);
    stroke(0);
    strokeWeight(5);
  }
  
  boolean update() { //true if still on screen, false otherwise.
    y-=30; //speed
    if(y < 0) {
      return false;
    }
    return true;
  }
  
  int[] getCoord() { //for collision checking
    int[] rtn = {x, y};
    return rtn;
  }
  
}
