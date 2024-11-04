class SpinningEnemyBullet extends EnemyBullet{
  
  StandardEnemyBullet(float x, float y, float angle) {
    super(x, y, 9, 9, angle, 6, 2); //(changed-not) FAST BULLET
    int[] rgb = {110, 35, 62};
    setRGB(rgb);
  }
  
  void update() {
    y+=yVelocity*Math.sin(angle); //calculating difference for where to draw the circle
    x+=xVelocity*Math.cos(angle);
    drawBullet();
  }
}