/* //<>//
 Name: Giacomo Cavarretta
 Student Number: 20104117
 
 TO WRITE HERE: what your code does
 
 Idea to develop:
 
 something like super mario where you can jump and move around. Need to implement gravity
 
 Let's start with the character size, moving around the frame, running and jumping.
 Gravity and collision detection with floor and walls.
 
 Then start creating some object to jump around
 
 He can fire like guts of wind. I can do something resembling Yasuo
 
 Building the engine, the skeleton of the game. Only at the end see how to implement the graphic.
 
 Enemies could be flying points like drones and you score destroying them.
 
 Fires a hit should work clickinkg on them to direct the projectiles.
 
 Projectiles should have a lifespan of a specific space travelled.
 
 Translate method could be useful when I want to move toward a place out of camera.
 
 When fired a projectile, put a method into draw() that check every time the current position of the projectile
 and if it's equal to another object under observation, both have to be terminated.
 
 @@@@@@@@@@@
 TO SOLVE
 @@@@@@@@@@@
 
 - bug when land from a jump (minor)
 - implement terrain and objects fixed on a certain height
 - implement new class to create a projectile to fire that will be the wind guts
 - implement an enemy to target
 - implement a collision detection between projectile and the enemy
 */

///////////////////////////////////////////////////////////////////
//------------------------- GLOBAL VARS -------------------------//
///////////////////////////////////////////////////////////////////

Player player = new Player();
Projectile p = new Projectile();

////////////////
// SETTINGS

float walkVelocity = 10;
float walkAcceleration = 1;
float jumpVelocity = 30;
float jumpAcceleration = 2;
float running = 5;

////////////////
// KEYS

Key k1 = new Key("Jump", true);
Key k2 = new Key("Left", false);
Key k3 = new Key("Right", false);
Key k4 = new Key("Run", false);

///////////////////////////////////////////////////////////////////////
//------------------------- EVENT LISTENERS -------------------------//
///////////////////////////////////////////////////////////////////////

void keyPressed() {
  if (!k1.active && key == 'w' || key == 'W') {
    k1.setActive(true);
  }
  if (key == 'a' || key == 'A') { //left
    k2.setActive(true);
  }
  if (key == 'd' || key == 'D') { //right
    k3.setActive(true);
  }
  if (keyCode==SHIFT) {
    k4.setActive(true);
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    k1.setActive(false);
    k1.setOnce(true);
  }
  if (key == 'a' || key == 'A') { //left
    k2.setActive(false);
  }
  if (key == 'd' || key == 'D') { //right
    k3.setActive(false);
  }
  if (keyCode==SHIFT) {
    k4.setActive(false);
  }
}

///////////////////////////////////////////////////////////////////////
//------------------------- BESPOKE METHODS -------------------------//
///////////////////////////////////////////////////////////////////////

void playActiveKeys() {
  runWalk();
  runJump();
}

void runJump() {
  if (k1.once && k1.active && player.getAcceleration()[1] == 0) {
    player.setVelocity(player.getVelocity()[0], jumpVelocity * -1);
    player.setAcceleration(player.getAcceleration()[0], jumpAcceleration);
    k1.setOnce(false);
  }
}
void runWalk() {
  if (k2.active) {
    player.setVelocity(walkVelocity * -1, player.getVelocity()[1]);
    player.setAcceleration(walkAcceleration, player.getAcceleration()[1]);
  }
  if (k2.active && k4.active) {
    player.setVelocity((walkVelocity * -1) - running, player.getVelocity()[1]);
    player.setAcceleration(walkAcceleration, player.getAcceleration()[1]);
  }
  if (k3.active) {
    player.setVelocity(walkVelocity, player.getVelocity()[1]);
    player.setAcceleration(walkAcceleration * -1, player.getAcceleration()[1]);
  }
  if (k3.active && k4.active) {
    player.setVelocity(walkVelocity + running, player.getVelocity()[1]);
    player.setAcceleration(walkAcceleration * -1, player.getAcceleration()[1]);
  }
}

////////////////////////////////////////////////////////////
//------------------------- MAIN -------------------------//
////////////////////////////////////////////////////////////

void setup() {
  size(1280, 720);
  surface.setLocation(0, 0);
}

void draw() {
  playActiveKeys();
  background(255);
  player.updatePosition();
}
