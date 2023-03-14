public class Player {

  //------------//
  //   FIELDS   //
  //------------//

  private float [] size = {20, 40};
  private float [] position = {(1280/2)- (this.size[0]/2), (720-this.size[1])};
  private float [] velocity = {0, 0};
  private float [] acceleration = {0, 0};

  //------------------//
  //   GETS AND SETS  //
  //------------------//

  public float[] getSize() {
    return new float[]{this.size[0], this.size[1]};
  }

  public void setSize(float w, float h) {
    this.size[0]=w;
    this.size[1]=h;
  };

  public float[] getPosition() {
    return new float[]{this.position[0], this.position[1]};
  }

  public void setPosition(float x, float y) {
    this.position[0]=x;
    this.position[1]=y;
  }

  public float[] getVelocity() {
    return new float[]{this.velocity[0], this.velocity[1]};
  }

  public void setVelocity(float x, float y) {
    this.velocity[0]=x;
    this.velocity[1]=y;
  }

  public float[] getAcceleration() {
    return new float[]{this.acceleration[0], this.acceleration[1]};
  }

  public void setAcceleration(float x, float y) {
    this.acceleration[0]=x;
    this.acceleration[1]=y;
  }



  //------------------//
  //   CONSTRUCTORS   //
  //------------------//

  Player() {
  }

  //-------------//
  //   METHODS   //
  //-------------//

  void toGround() {
    if (this.position[1] > 680) {
      this.acceleration[1] = 0;
      this.velocity[1] = 0;
      this.position[1] = 680;
    }
    if ((this.position[0] > 1280) || (this.position[0] < 0)) {
      this.acceleration[0] *= -1;
      this.velocity[0] *= -1;
    }
    if ((this.velocity[0] > -1) && (this.velocity[0] < 1)) {
      this.acceleration[0] = 0;
      this.velocity[0] = 0;
    }
    if ((this.velocity[0] > -1) && (this.velocity[0] < 1)) {
      this.acceleration[0] = 0;
      this.velocity[0] = 0;
    }
  }

  void display()
  {
    rect(this.position[0], this.position[1], this.size[0], this.size[1]);
  }

  void updatePosition() {
    this.position[0]+=this.velocity[0];
    this.position[1]+=this.velocity[1];
    this.velocity[0]+=this.acceleration[0];
    this.velocity[1]+=this.acceleration[1];
    rect(this.position[0], this.position[1], this.size[0], this.size[1]);
    this.toGround();
  }
}
