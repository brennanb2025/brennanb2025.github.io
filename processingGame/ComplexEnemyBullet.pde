class ComplexEnemyBullet extends EnemyBullet {
  int timeDelay;
  int p2x, p2y, p3x, p3y;
  
  ComplexEnemyBullet(float x, float y, float angle) { //TODO: make these triangles or something.
    super(x, y, -3, -3, angle, 5, 2); //x, y, xVel, yVel, angle, radius, strokeWeight. CHANGE RADIUS EVENTUALLY.
    int[] rgb = {41, 142, 121};
    setRGB(rgb);
    timeDelay = 0;
  }
  
  void update() {
    if(timeDelay >= 100) { //wait 100 frames before the bullets move.
      y+=yVelocity*Math.sin(radians(angle)); //calculating difference for where to draw the circle
      x+=xVelocity*Math.cos(radians(angle));
    }
    
    show();
    timeDelay++;
  }
  
  void show() {
    
    strokeWeight(2);
    fill(rgb[0], rgb[1], rgb[2]);
    p2x = -10;
    p2y = 30;
    p3x = 10;
    p3y = 30;
    
    pushMatrix();
    translate(x,y); //translate the origin draw to x,y
    rotate(radians(angle-90)); //rotate the plane to point the triangle towards the player
    triangle(0, 0, p2x, p2y, p3x, p3y); //make the triangle on these coordinates away from the (translated) origin.
    popMatrix();
    
    p2x+=x;
    p2y+=x;
    p3x+=x;
    p3y+=x;
    
    strokeWeight(5);
  }
  
  /*boolean checkCollision(Player player) {
    
    float playerX = player.getCoord()[0];
    float playerY = player.getCoord()[1];
    
    float area = 0.5 *(-p2y*p3x + y*(-p2x + p3x) + x*(p2y - p3y) + p2x*p3y);
    
    float s = 1/(2*area)*(y*p3x - x*p3y + (p3y - y)*playerX + (x - p3x)*playerY);
    float t = 1/(2*area)*(x*p2y - y*p2x + (y - p2y)*playerX + (p2x - x)*playerY);
    //where Area is the (signed) area of the triangle:
    
    return (s>0 && t>0 && 1-s-t>0);
    
  }*/
  
}
