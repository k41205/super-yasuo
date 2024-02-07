public class Player {

  //---------- FIELDS ----------//

  private String name;
  private float[] size = new float [2];
  private float[] position = new float [2];
  private float[] speed = new float [2];
  private float[] acceleration = new float [2];
  private PImage img;

  //---------- CONSTRUCTORS ----------//

  public Player(String name) {
    setName(name);
    setSize(20, 40);
    setPosition(1280 / 2 - size[0] / 2, 720 - size[1]);
    setSpeed(0, 0);
    setAcceleration(0, 0);
    img = loadImage("player1.png");
  }

  //---------- GETTERS/SETTERS ----------//

  public String getName() {
    return name;
  }

  public void setName(String name) {
    // truncate the name to 10 characters if it's longer than 10 characters
    if (name == null) name = "Anonymous";
    name = name.trim(); // remove leading and trailing whitespace
    if (name.length() > 10) {
      this.name = name.substring(0, 10);
    } else {
      this.name = name;
    }
  }

  public float[] getSize() {
    return size;
  }

  public void setSize(float w, float h) {
    size[0]=w;
    size[1]=h;
  }

  public float[] getPosition() {
    return position;
  }

  public void setPosition(float x, float y) {
    position[0]=x;
    position[1]=y;
  }

  public float[] getSpeed() {
    return speed;
  }

  public void setSpeed(float x, float y) {
    speed[0]=x;
    speed[1]=y;
  }

  public float[] getAcceleration() {
    return acceleration;
  }

  public void setAcceleration(float x, float y) {
    acceleration[0]=x;
    acceleration[1]=y;
  }

  //---------- METHODS ----------//

  // Make the player appear in the game
  public void display()
  {
    noFill();
    noStroke();
    //fill(0,255,0); // Debug purpose
    textSize(24);
    text(name, position[0] + size[0] / 2 - textWidth(name) / 2, position[1] - 10);
    rect(position[0], position[1], size[0], size[1]);
    image(img, position[0], position[1], size[0], size[1]);
  }

  public void updatePosition() {
    position[0] += speed[0];
    position[1] += speed[1];
    speed[0] += acceleration[0];
    speed[1] += acceleration[1];

    // Reset X speed and acceleration when the player stops to move
    if (speed[0] > -1 && speed[0] < 1) {
      acceleration[0] = 0;
      speed[0] = 0;
    }

    // Reset Y speed and acceleration when the player reach the ground
    if (position[1] == height - size[1]) {
      acceleration[1] = 0;
      speed[1] = 0;
    }

    // Constrain the movements to the window size
    position[0] = min(max(position[0], 0), width - size[0]);
    position[1] = min(max(position[1], 0), height - size[1]);
  }

  // Draw an imaginary line between the player and the pointer
  public void displayAim() {
    stroke(0);
    strokeWeight(2);
    line(position[0] + size[0] / 2, position[1] + size[1] / 2, mouseX, mouseY);
  }

  public boolean hasCollided(float[] enemyPosition, float enemySize) {
    // Calculate the half-width and half-height of the rectangle
    float halfWidth = getSize()[0] / 2;
    float halfHeight = getSize()[1] / 2;

    // Calculate the center position of the rectangle
    float rectCentreX = getPosition()[0] + halfWidth;
    float rectCentreY = getPosition()[1] + halfHeight;

    // Calculate the distance between the circle center and the rectangle center
    float dx = abs(enemyPosition[0] - rectCentreX);
    float dy = abs(enemyPosition[1] - rectCentreY);

    // If the distance is greater than half the width + radius or half the height + radius, they do not intersect
    if (dx > halfWidth + enemySize / 2 || dy > halfHeight + enemySize / 2) {
      return false;
    }

    // If the distance is less than half the width or half the height, they intersect
    if (dx <= halfWidth || dy <= halfHeight) {
      return true;
    } else return false;
  }
}
