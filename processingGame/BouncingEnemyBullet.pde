class BouncingEnemyBullet extends EnemyBullet {
  String direction;
  
  BouncingEnemyBullet(float x, float y, float angle) {
    super(x, y, 6, 6, angle, 10, 2);
    int[] rgb = {247, 225, 56};
    setRGB(rgb);
  }
  
  void update() {
    bounced = shouldBounce();

    if(bounced) { //bounced, should go switch direction
      angle = 180-angle;
    }
    
    y+=yVelocity*Math.sin(radians(angle)); //calculating difference for where to draw the circle
    x+=xVelocity*cos(radians(angle));
    
    strokeWeight(stroke_weight);
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y, radius*2, radius*2);
    strokeWeight(5);
  }
  
  boolean shouldBounce() {
    if(x <= 10 || x >= width-10) { //out of bounds
      return true;
    }
    return false;
  }
}
