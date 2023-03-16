public class Projectile {

  //double id = Math.random();
  float size;
  float [] position;
  //float [] velocity = {10,10};
  //float [] acceleration = {-1,1};
  float velocity = 1;
  float acceleration = 0.2;

  Projectile() {
  }

  void updatePosition() {
    this.position[0]+=velocity;
    //this.position[1]+=velocity;
    this.position[2]+=velocity;
    //this.position[3]+=velocity;
    this.velocity+=acceleration;
    line(this.position[0], this.position[1], position[2], this.position[3]);
  }

  float [] getPosition() {
    return this.position;
  }

  void setPosition(float [] playerPosition) {
    this.position = new float[]{playerPosition[0]+20, playerPosition[1], playerPosition[0]+20, playerPosition[1]+40};
  }
}
