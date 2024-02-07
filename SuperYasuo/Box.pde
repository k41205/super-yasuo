public class Box {

  //---------- FIELDS ----------//

  private float size;
  private float[] position = new float[2];
  private PImage img;

  //---------- CONSTRUCTORS ----------//

  public Box() {
    setSize(40);
    setRandomPosition();
    img = loadImage("box.png");
  }

  //---------- GETTERS/SETTERS ----------//

  public void setRandomPosition() {
    position[0] = random(0, width - size);
    position[1] = 720 - size;
  }

  public float getSize() {
    return size;
  }

  public void setSize(float size) {
    this.size = size;
  }

  public float[] getPosition() {
    return position;
  }

  //---------- METHODS ----------//

  public void display() {
    rect(position[0], position[1], size, size);
    image(img, position[0], position[1], size, size);
  }

  /* I need to check if two rectangles collide with each other. To verify that I simply
   check if each side of the player are colliding with the box */

  public boolean hasCollided(float[] playerPosition, float[] playerSize) {
    float left = position[0];
    float right = position[0] + size;
    float top = position[1];
    float bottom = position[1] + size;
    float rectLeft = playerPosition[0];
    float rectRight = playerPosition[0] + playerSize[0];
    float rectTop = playerPosition[1];
    float rectBottom = playerPosition[1] + playerSize[1];
    return left < rectRight && right > rectLeft && top < rectBottom && bottom > rectTop;
  }
}
