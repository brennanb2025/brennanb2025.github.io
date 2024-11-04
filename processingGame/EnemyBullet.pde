class EnemyBullet {
  double xVelocity, yVelocity;
  float x, y, angle;
  int[] rgb;
  int radius, stroke_weight;
  
  EnemyBullet(float x, float y, double xVel, double yVel, float angle, int radius, int stroke_weight) {
    this.x = x;
    this.y = y;
    xVelocity = xVel;
    yVelocity = yVel;
    this.angle = angle;
    this.radius = radius;
    this.stroke_weight = stroke_weight;
  }
  
  void setRGB(int[] rgb) {
    this.rgb = rgb;
  }
  
  void update() {
    y+=yVelocity*Math.sin(radians(angle)); //calculating difference for where to draw the circle
    x+=xVelocity*Math.cos(radians(angle));
  }

  void show() {
    strokeWeight(stroke_weight);
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x, y, radius*2, radius*2);
    strokeWeight(5);
  }
  
  boolean checkCollision(Player player) { //not actually circles
    
    float minDistance = 5+radius; //add 5 for the radius of this player, radius for this EnemyBullet.
    float xDiff = Math.abs(x-player.getCoord()[0]);
    float yDiff = Math.abs(y-player.getCoord()[1]);
    
    if(xDiff < minDistance && yDiff < minDistance) {
      return true; //true, there was a collision
    }
    return false; //no collision
  }
  
  boolean onScreen() {
    if(x <= 0 || x >= width || y <= 0 || y >= height) { //out of bounds
      return false;
    }
    return true;
  }
  
}