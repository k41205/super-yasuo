class Enemy {

  //---------- FIELDS ----------//

  private int size;
  private float[] position = new float[2];
  private float speed;
  private int level;
  private PImage img;

  //---------- CONSTRUCTORS ----------//

  public Enemy() {
    setRandomSize();
    setRandomPosition();
    setSpeed(0);
    setLevel(0);
    img = loadImage("drone.png");
  }

  public Enemy(int level, float speedGrowth) {
    setRandomSize();
    setRandomPosition();
    setSpeed(speedGrowth);
    setLevel(level);
    img = loadImage("drone.png");
  }

  //---------- GETTERS/SETTERS ----------//

  public float[] getPosition() {
    return position;
  }

  /* I want the enemies to spawn from the top so I chose to set
   a random position in the top half height of the screen */

  public void setRandomPosition() {
    int sizeWidth = 1280;
    int sizeHeight = 720;
    int halfHeight = sizeHeight / 4;

    int minX = 0;
    int maxX = sizeWidth;
    int minY = 0;
    int maxY = halfHeight;

    int rangeX = maxX - minX + 1;
    int rangeY = maxY - minY + 1;
    float randomX = random(rangeX) + minX;
    float randomY = random(rangeY) + minY;
    this.position = new float[] {randomX, randomY};
  }

  public float getSize() {
    return size;
  }

  public void setRandomSize() {
    int min = 20;
    int max = 50;
    int range = max - min + 1;
    int randomNum = (int) random(range) + min;

    /* Set a random size between min and max being the final
     value divisible by five to have 3 sizes of the enemy */

    int divisibleByFive = (randomNum / 5) * 5;
    this.size = divisibleByFive;
  }

  public float getSpeed() {
    return speed;
  }

  public void setSpeed(float growthSpeed) {
    // Set the speed to a value that is smaller the larger size is
    speed = map(size, 5, 50, 1, growthSpeed) + getLevel()/2;
  }

  public int getLevel() {
    return level;
  }

  public void setLevel(int level) {
    this.level = level;
  }

  //---------- METHODS ----------//

  public void target(float[] playerPosition, float[] playerSize) {
    // difference between xCoord of player and enemy position centres
    float dx = (playerPosition[0] + playerSize[0] / 2) - position[0];
    // difference between yCoord of player and enemy position centres
    float dy = (playerPosition[1] + playerSize[1] / 2) - position[1];

    /* Given Y and X coordinates return the angle of the tangent in radians.
     This angle is needed to calculate the X and Y coords by the use of
     cos and sin functions that will address the enemy toward the player,
     at the rate by which we multiply it*/

    float angle = atan2(dy, dx);

    // Move towards the player
    position[0] += cos(angle) * speed;
    position[1] += sin(angle) * speed;

    // Constrain the movements to the window size
    position[0] = min(max(position[0], 0), width);
    position[1] = min(max(position[1], 0), height);
  }

  public void display() {
    //fill(255, 0, 0); // debug purpose
    noFill();
    stroke(0);
    circle(position[0], position[1], size);
    image(img, position[0] - size / 2, position[1] - size / 2, size, size);
  }

  public boolean hasCollided(float[] projectilePosition) {
    // Calculate the distance from the circle center to the line segment
    float dx = projectilePosition[2] - projectilePosition[0];
    float dy = projectilePosition[3] - projectilePosition[1];

    /* Math formula to calculate the projection of the enemy centre position
     to the line segment which represent the projectile:
     
     t = ((x - x1) * (x2 - x1) + (y - y1) * (y2 - y1)) / ((x2 - x1)^2 + (y2 - y1)^2)
     
     */
    float t = ((position[0] - projectilePosition[0]) * dx + (position[1] - projectilePosition[1]) * dy) / (dx * dx + dy * dy);
    float distX, distY;

    if (t < 0) {
      // The closest point on the line is outside of the line segment, closer to the start point of the segment
      distX = position[0] - projectilePosition[0];
      distY = position[1] - projectilePosition[1];
    } else if (t > 1) {
      // The closest point on the line is outside of the line segment, closer to the end point of the segment
      distX = position[0] - projectilePosition[2];
      distY = position[1] - projectilePosition[3];
    } else {
      // The closest point on the line is inside of the line segment, calculate distance from circle center
      distX = position[0] - (projectilePosition[0] + t * dx);
      distY = position[1] - (projectilePosition[1] + t * dy);
    }

    // Check if the distance is less than the circle radius
    return (distX * distX + distY * distY) < (size / 2 * size / 2);
  }

  // Destroy the enemy by setting its size to zero
  public void destroy() {
    size = 0;
  }
}
