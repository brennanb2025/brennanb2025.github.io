class GodKianaBullet extends EnemyBullet {
  
  GodKianaBullet(float x, float y, float angle, float xVel, float yVel) {
    super(x, y, xVel, yVel, angle, 10, 2); //xVel should be 5??
    int[] rgb = {255, 170, 35};
    setRGB(rgb);
  }
  
  void update() {
    
    y+=yVelocity*Math.sin(angle); //calculating difference for where to draw the circle
    x+=xVelocity*Math.cos(angle);
    
    drawBullet();
  }
  
  void drawBullet() {
    strokeWeight(strokeWeight);
    stroke(255);
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y, radius*2, radius*2);
    stroke(0);
    strokeWeight(5);
  }
  
}
