class StandardEnemyBullet extends EnemyBullet{
  
  StandardEnemyBullet(float x, float y, float angle) {
    super(x, y, 5, 5, angle, 10, 2);
    int[] rgb = {247, 225, 56};
    setRGB(rgb);
  }
  
}
