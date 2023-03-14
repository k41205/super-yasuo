/* //<>//
 Name: Giacomo Cavarretta
 Student Number: 20104117
 
 TO WRITE HERE: what your code does
 
 Idea to develop:
 
 something like super mario where you can jump and move around. Need to implement gravity
 
 Let's start with the character size, moving around the frame, running and jumping.
 Gravity and collision detection with floor.
 
 Then start creating some object to jump around
 
 He can fire like guts of wind. I can do something resembling Yasuo
 
 Building the engine, the skeleton of the game. Only at the end see how to implement the graphic.
 
 @@@@@@@@@@@
 TO SOLVE
 @@@@@@@@@@@
 
 - bug when land from a jump (minor)
 - fix the walls at the end to not go beyond those
 - walk toward a direction just pressing the arrows
 (then try if I can jump and walk at the same time)
 - implement running
 - implement terrain and objects fixed on a certain height
 - implement new class to create a projectile to fire that will be the wind guts
 */

Player player = new Player();

//EVENT LISTENER
void keyPressed() {
  float posX = player.getPosition()[0];
  float posY = player.getPosition()[1];
  float velX = player.getVelocity()[0];
  float velY = player.getVelocity()[1];
  float accX = player.getAcceleration()[0];
  float accY = player.getAcceleration()[1];
  player.getAcceleration();
  if (accY == 0 && keyPressed && key == ' ') {
    player.setVelocity(0,-30);
    player.setAcceleration(0,2);
  }
  if (keyCode==39) { //right
    player.setVelocity(10,velY);
    player.setAcceleration(-1,accY);
  }
  if (keyCode==37) { //left
    player.setVelocity(-10,velY);
    player.setAcceleration(1,accY);
  }
}
//MAIN
void setup() {
  size(1280, 720);
  surface.setLocation(0, 0);
}

void draw() {
  background(255);
  //player.display();
  player.updatePosition();

  ////////// BOUNDARIES

  //if (pos[1] > 620) {
  //  acc[1] =0;
  //  vel[1]=0;
  //  pos[1]=620;
  //}
}
