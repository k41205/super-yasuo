class Bomb {

  //---------- FIELDS ----------//

  private float[] position = new float[2];
  private float size;
  private float maxSize;

  //---------- CONSTRUCTORS ----------//

  // Default constructor needed to avoid NullPointerException when the game is running
  public Bomb() {
    setPosition(new float[]{0, 0}, new float[]{0, 0});
    setSize(0);
    setMaxSize(0);
  }

  public Bomb(float maxSize, float[] playerPosition, float[] playerSize) {
    setPosition(playerPosition, playerSize);
    setSize(20);
    setMaxSize(maxSize);
  }

  //---------- GETTERS/SETTERS ----------//

  public void setPosition(float[] playerPosition, float[] playerSize) {
    position[0] = playerPosition[0] + playerSize[0] / 2;
    position[1] = playerPosition[1] + playerSize[1] / 2;
  }

  public float getSize() {
    return size;
  }

  public void setSize(float size) {
    this.size = size;
  }

  public void setMaxSize(float maxSize) {
    this.maxSize = maxSize;
  }

  public void display() {
    noStroke();
    fill(255);
    circle(position[0], position[1], size);
  }

  //---------- METHODS ----------//

  public void update() {
    // To animate the bomb explosion
    if (size < maxSize) {
      size *= 1.2;
      // End of the animation
    } else size = 0;
  }

  public boolean hasCollided(float[] enemyPosition) {

    /*  I need to check if two circles collide with each other. To verify that I need
     to calculate the distance between two points in a 2D plane I used the following math formula:
     
     distance = sqrt((x2 - x1)^2 + (y2 - y1)^2)
     
     If the distance is equal or minor to the bomb radius, a collision has occurred */

    float distance = (float) sqrt((enemyPosition[0] - position[0]) * (enemyPosition[0] - position[0]) + (enemyPosition[1] - position[1]) * (enemyPosition[1] - position[1]));
    if (distance <= size / 2) {
      return true;
    } else {
      return false;
    }
  }
}
