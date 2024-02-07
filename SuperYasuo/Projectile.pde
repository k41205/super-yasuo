public class Projectile {

  //---------- FIELDS ----------//

  private float [] position = new float[2];
  private float size;
  // To avoid the projectile moving with the mouse, call setAngle just when I hit the button
  private float angle;
  private float[] delta = new float[2];
  private float speed;

  //---------- CONSTRUCTORS ----------//

  public Projectile() {
    setSize(0);
    setSpeed(0);
    setAngle(new float[]{0, 0}, new float[]{0, 0});
    setDelta(new float[]{0, 0});
    setPosition(new float[]{0, 0}, new float[]{0, 0});
  }

  public Projectile(float[] currentPlayerPosition, float [] currentPlayerSize) {
    setSize(40);
    setSpeed(20);
    setAngle(currentPlayerPosition, currentPlayerSize);
    setDelta(currentPlayerPosition);
    setPosition(currentPlayerPosition, currentPlayerSize);
  }

  //---------- GETTERS/SETTERS ----------//

  public float getSize() {
    return size;
  }

  public void setSize(float size) {
    this.size = size;
  }

  public void setSpeed(float speed) {
    this.speed = speed;
  }

  // Calculate the angle between the horizontal axis and the line that goes from the player centre to the mouse position
  private void setAngle(float[] currentPlayerPosition, float[] currentPlayerSize) {
    float centrePlayerX = currentPlayerPosition[0] + currentPlayerSize[0] / 2;
    float centrePlayerY = currentPlayerPosition[1] + currentPlayerSize[1] / 2;
    float dx = mouseX - centrePlayerX;
    float dy = mouseY - centrePlayerY;
    float slope = dy / dx;
    this.angle = atan(slope);
  }

  private void setDelta(float [] currentPlayerPosition) {

    /* Taking the player centre as the origin of the Cartesian plane
     we set the direction where the projectile has to go based
     on the angle calculated earlier */

    // Top-left
    if (sin(angle) > 0 && mouseX - currentPlayerPosition[0] < 0) {
      delta[0] = cos(angle) * -speed;
      delta[1] = sin(angle) * -speed;
    }
    // Top-right
    if (sin(angle) < 0 && mouseX - currentPlayerPosition[0] > 0) {
      delta[0] = cos(angle) * speed;
      delta[1] = sin(angle) * speed;
    }
    // Bottom-left
    if (sin(angle) < 0 && mouseX - currentPlayerPosition[0] < 0) {
      delta[0] = cos(angle) * -speed;
      delta[1] = sin(angle) * -speed;
    }
    // Bottom-right
    if (sin(angle) > 0 && mouseX - currentPlayerPosition[0] > 0) {
      delta[0] = cos(angle) * speed;
      delta[1] = sin(angle) * speed;
    }
  }

  public float[] getPosition() {
    return position;
  }

  /* Calculate the position of the projectile by multiplying the player centre by
   the cos for X and sin for Y of the angle calculated earlier + 90deg because
   we want to draw a segment perpendicular to us */

  public void setPosition(float[] currentPlayerPosition, float[] currentPlayerSize) {
    float centrePlayerX = currentPlayerPosition[0] + currentPlayerSize[0] / 2;
    float centrePlayerY = currentPlayerPosition[1] + currentPlayerSize[1] / 2;
    float x1 = centrePlayerX - size / 2 * cos(this.angle + HALF_PI);
    float y1 = centrePlayerY - size / 2 * sin(this.angle + HALF_PI);
    float x2 = centrePlayerX + size / 2 * cos(this.angle + HALF_PI);
    float y2 = centrePlayerY + size / 2 * sin(this.angle + HALF_PI);
    this.position = new float[]{x1, y1, x2, y2};
  }

  //---------- METHODS ----------//

  public void display() {
    stroke(255);
    line(position[0], position[1], position[2], position[3]);
  }

  public void updatePosition() {
    position[0] += delta[0];
    position[1] += delta[1];
    position[2] += delta[0];
    position[3] += delta[1];
    constrainToWindowSize();
  }

  private void constrainToWindowSize() {
    if (position[0] < 0 - size || position[0] > 1280 + size || position[1] < 0 - size || position[1] > 720 + size) {
      setSize(0);
      setSpeed(0);
      setAngle(new float[]{0, 0}, new float[]{0, 0});
      setDelta(new float[]{0, 0});
      setPosition(new float[]{0, 0}, new float[]{0, 0});
    }
  }
}
