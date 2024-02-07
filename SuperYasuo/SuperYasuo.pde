/* //<>//
 Name: Giacomo Cavarretta
 Student Number: 20104117
 
 The game is a shooter where the player shoots enemies (drones) with wind blows by
 using his katana and can throw bombs that can be collected on the floor when they spawn.
 The game has 3 different difficulty levels and keeps track of the player's score.
 */

import javax.swing.JOptionPane;
import processing.sound.*;

//---------- GLOBAL VARS ----------//

// ENTITIES

/*  To avoid the recreation of a projectile in flight
 I set length 10 to have enough projectiles to fire
 which can be in flight at the same time without
 falling in that problem */

Projectile[] projectiles = new Projectile[10];

// Maximum 100 matches in a row
Score[] allScores = new Score[100];
Box[] boxes;
Enemy[] enemies;
Bomb bomb;
Player player;

/*  SETTINGS APP
 Do not touch these settings to let the app run properly */

PImage backgroundImage;
PFont customFont;
SoundFile soundBomb;
SoundFile soundProjectile;
SoundFile soundDeath;

String playerName;
int gameNumber = 0;
int gamePlayed = 0;

/*  SETTINGS GAME
 Different values each game, most of them
 will be managed by the chosen level of difficulty */

String difficulty;
int hits = 0;
int level = 0;
int numBoxes = 5;
int health = 100;
int boxForHits;
float aggressivity;
int numEnemies;

/*  INDEXES AND FLAGS
 Do not touch these settings to let the app run properly */

int ammoIndex = 0;
int boxIndex;
int bombNumber;
boolean isFired = false;
boolean boxCreated = false;
boolean gameOn = false;

/*  SETTINGS PHYSICS
 These are the advised values but you can play with them.
 For example you can change walkAcceleration to 0.5 to have
 a more slidey movement */

float walkSpeed = 10;            //speed when moving left or right
float walkAcceleration = 1;      //value that decrease the velocity over time. It works as a friction
float runningSpeed = 15;         //increased speed when running
float jumpSpeed = 30;
float jumpAcceleration = 2;
float bombSize = 1000;

/*  SETTINGS KEYS
 Keys are not active till when pressed and go inactive when released.
 This means that the action is repeated as long as the key is pressed.
 However, jump, fire, and bomb keys have the field "once" set as true.
 That means that these keys have to be released and press again to
 repeat that action */

Key k1 = new Key();  // Jump
Key k2 = new Key(); // Left
Key k3 = new Key(); // Right
Key k4 = new Key(); // Run
Key k5 = new Key();  // Fire
Key k6 = new Key();  // Bomb

//---------- EVENT LISTENERS ----------//

void keyPressed() {
  // Jump
  if (!k1.getIsActive() && key == 'w' || key == 'W') {
    k1.setIsActive(true);
  }

  // Walk left
  if (key == 'a' || key == 'A') {
    k2.setIsActive(true);
  }

  // Walk right
  if (key == 'd' || key == 'D') {
    k3.setIsActive(true);
  }

  // Running mode
  if (keyCode==SHIFT) {
    k4.setIsActive(true);
  }

  // Throw a bomb
  if (key == ' ') {
    k5.setIsActive(true);
  }
}

void keyReleased() {
  // Jump
  if (key == 'w' || key == 'W') {
    k1.setIsActive(false);
    k1.setIsDisabled(false);
  }

  // Walk left
  if (key == 'a' || key == 'A') {
    k2.setIsActive(false);
  }

  // Walk right
  if (key == 'd' || key == 'D') {
    k3.setIsActive(false);
  }

  // Running mode
  if (keyCode==SHIFT) {
    k4.setIsActive(false);
  }

  // Throw a bomb
  if (key == ' ') {
    k5.setIsActive(false);
    k5.setIsDisabled(false);
  }
}

void mousePressed() {
  // Fires
  if (mouseButton == LEFT) {
    k6.setIsActive(true);
  }
}

void mouseReleased() {
  // Fires
  if (mouseButton == LEFT) {
    k6.setIsActive(false);
    k6.setIsDisabled(false);
  }
}

//---------- BESPOKE METHODS ----------//

/*  ACTIONS' CONTROLLER
 This function is invoked in the draw() and runs the action for every pressed keys/buttons */

void checkPressedKeys() {
  runMove();
  runJump();
  runFire();
  runBomb();
}

/*  ACTIONS
 Here are found all the functions related to the possible actions in the game */

void runJump() {
  // Jump - W has to be released and acceleration has to be reset to avoid jumping in the air
  if (!k1.getIsDisabled() && k1.getIsActive() && player.getAcceleration()[1] == 0) {
    player.setSpeed(player.getSpeed()[0], jumpSpeed * -1);
    player.setAcceleration(player.getAcceleration()[0], jumpAcceleration);
    k1.setIsDisabled(true);
  }
}

void runMove() {
  // Walking left
  if (k2.getIsActive()) {
    player.setSpeed(walkSpeed * -1, player.getSpeed()[1]);
    player.setAcceleration(walkAcceleration, player.getAcceleration()[1]);
  }
  // Walking right
  if (k3.getIsActive()) {
    player.setSpeed(walkSpeed, player.getSpeed()[1]);
    player.setAcceleration(walkAcceleration * -1, player.getAcceleration()[1]);
  }
  // When "A" and "D" are pressed at the same time, the player stops moving
  if (k2.getIsActive() && k3.getIsActive()) {
    player.setSpeed(0, player.getSpeed()[1]);
    player.setAcceleration(0, player.getAcceleration()[1]);
  }

  // Running left
  if (k2.getIsActive() && k4.getIsActive()) {
    player.setSpeed(runningSpeed * -1, player.getSpeed()[1]);
    player.setAcceleration(walkAcceleration, player.getAcceleration()[1]);
  }
  // Running right
  if (k3.getIsActive() && k4.getIsActive()) {
    player.setSpeed(runningSpeed, player.getSpeed()[1]);
    player.setAcceleration(walkAcceleration * -1, player.getAcceleration()[1]);
  }
  // When "A" and "D" are pressed at the same time, the player stops moving
  if (k2.getIsActive() && k3.getIsActive() && k4.getIsActive()) {
    player.setSpeed(0, player.getSpeed()[1]);
    player.setAcceleration(0, player.getAcceleration()[1]);
  }
}

void runFire() {
  if (!k6.getIsDisabled() && k6.getIsActive()) {
    // I implemented this mechanism to keep rotating the projectiles from 0 to 9
    int nextIndex = (ammoIndex + 1) % projectiles.length; // get next available index
    projectiles[ammoIndex] = new Projectile(player.getPosition(), player.getSize());
    ammoIndex = nextIndex; // update ammoIndex to the next available index
    soundProjectile.play();
    k6.setIsDisabled(true);
  }
}

void runBomb() {
  // To throw a more than one bomb in a row, you have to wait the end of the animation. For this the size of bomb has to be 0
  if (!k5.getIsDisabled() && k5.getIsActive() && bomb.getSize() == 0 && bombNumber > 0) {
    bomb = new Bomb(bombSize, player.getPosition(), player.getSize());
    k5.setIsDisabled(true);
    bombNumber --;
    soundBomb.play();
  }
}

/*  DIALOGS
 All the functions that show dialogs in the game
 to inform the user or to get some values from input */

void showPlayerCreationDialog() {
  // show a JOptionPane dialog box to get the player's name
  playerName = JOptionPane.showInputDialog(null, "Please enter your name:", "Player Name", JOptionPane.PLAIN_MESSAGE);
  // set Anonymous as playerName if no name has been typed or the window has been closed
  if (playerName == null || playerName.isEmpty()) {
    playerName = "Anonymous";
  }
}

// Informative dialog for the user at the start of the game
void showInstructionsDialog() {
  String message = "Welcome to the game " + playerName +"!\n\n" +
    "TO KNOW\n" +
    "Avoid being hit by enemies. Every time you get enough hits,\n" +
    "a box will spawn randomly on the floor. Walk on it to get bomb ammo!\n\n" +
    "KEYS\n" +
    "- Use the a and d keys to move\n" +
    "- Press w to jump\n" +
    "- Left click to fire a hit\n" +
    "- Press space bar to throw a bomb\n\n" +
    "DIFFICULTY\n" +
    "Easy = Health: High | Enemies: 5 | Enemy speed growth: Slow\n" +
    "Boxes in game: 10 | Hits per box: 10\n" +
    "Medium = Health: Medium | Enemies: 8 | Enemy speed growth: Medium\n" +
    "Boxes in game: 8 | Hits per box: 15\n" +
    "Hard = Health: Low | Enemies: 10 | Enemy speed growth: Fast\n" +
    "Boxes in game: 5 | Hits per box: 20\n\n" +
    "Press OK to start playing.";
  JOptionPane.showMessageDialog(null, message, "Instructions", JOptionPane.INFORMATION_MESSAGE);
}

void chooseDifficultyDialog() {
  String[] options = {"Easy", "Medium", "Hard"};
  int difficultyChosen = JOptionPane.showOptionDialog(null, "Choose difficulty level", "Difficulty", JOptionPane.DEFAULT_OPTION, JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
  switch (difficultyChosen) {
  case 0:
    // Easy mode selected
    health = 200;
    numBoxes = 10;
    boxForHits = 10;
    aggressivity = 0.1;
    numEnemies = 5;
    difficulty = "Easy";
    break;
  case 1:
    // Medium mode selected
    health = 150;
    numBoxes = 8;
    boxForHits = 15;
    aggressivity = 0.3;
    numEnemies = 8;
    difficulty = "Medium";
    break;
  case 2:
    // Hard mode selected
    health = 100;
    numBoxes = 5;
    boxForHits = 20;
    aggressivity = 0.5;
    numEnemies = 10;
    difficulty = "Hard";
    break;
  default:
    // If the window has been closed and no option has been chosen, default mode (Medium mode) will run
    health = 150;
    numBoxes = 8;
    boxForHits = 15;
    aggressivity = 0.3;
    numEnemies = 8;
    difficulty = "Medium";
    break;
  }
}

void showGameOverOptionsDialog() {
  String[] options = {"Play Again", "View Results", "Quit Game"};
  int option = JOptionPane.showOptionDialog(null, "What would you like to do?", "Game Over", JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE, null, options, null);

  if (option == JOptionPane.YES_OPTION) gameOn = false;
  if (option == JOptionPane.NO_OPTION) {
    showHighScoreDialog();
    showGameOverOptionsDialog();
  }
  if (option == JOptionPane.CANCEL_OPTION) exit();
}

void showHighScoreDialog() {
  String message = playerName + "'s high score:\n\n";
  int highScore = 0;

  for (gameNumber = 0; gameNumber < gamePlayed; gameNumber++) {
    if (allScores[gameNumber].getValue() > highScore) highScore = allScores[gameNumber].getValue();
    message += "Game "+ (gameNumber+1) + " (" + allScores[gameNumber].getDifficulty() + "): "+ allScores[gameNumber].getValue() +"\n";
  }

  message += "\nHigh score: " + highScore;
  JOptionPane.showMessageDialog(null, message, "High Score", JOptionPane.INFORMATION_MESSAGE);
}

/*  INITIALIZER
 This method is run every time at the start of the game to reset
 keys, indexes, flags, counters, and all the entities of the game */

void initGame() {
  // Keys
  k1.setIsActive(false);
  k2.setIsActive(false);
  k3.setIsActive(false);
  k4.setIsActive(false);
  k5.setIsActive(false);
  k6.setIsActive(false);

  // Flags, Indexes and Counters
  bombNumber = 0;
  boxIndex = 0;
  ammoIndex = 0;
  level = 0;
  hits = 0;

  // Entities
  player = new Player(playerName);
  boxes = new Box[numBoxes];
  enemies = new Enemy[numEnemies];
  bomb = new Bomb();

  int i = 0;
  while  (i < enemies.length) {
    enemies[i] = new Enemy();
    enemies[i].setSpeed(aggressivity);
    i++;
  }

  int j = 0;
  do {
    projectiles[j] = new Projectile();
    j++;
  } while (j < projectiles.length);
}

/*  GUI
 All the functions that are part of the GUI */

void GUI() {
  background(backgroundImage);
  stroke(0);
  textSize(32);
  fill(0, 255, 0);
  text("Health", 20, 40);
  rect(160, 20, health, 20);
  text("Bombs: " + bombNumber, 20, 80);
  text("Level: " + level, 1100, 40);
  text("Hits: " + hits, 1100, 80);
}

/*  PHASES OF THE GAMES PER FRAME
 I divided the phases of the game repeated for each frame to have
 a more modular code in the draw function and to simplify the debug */

void checkSpawnBoxes() {
  if (hits % boxForHits == 0 && !boxCreated && hits != 0 && boxIndex < numBoxes) {
    boxes[boxIndex] = new Box();
    boxes[boxIndex].display();
    boxIndex++;
    boxCreated = true;
  }

  for (Box b : boxes) {
    if (b != null) {
      b.display();
      if (b.hasCollided(player.getPosition(), player.getSize())) {
        b.setSize(0);
        bombNumber++;
      }
    }
  }
}

void checkProjectileInteractions() {
  for (int i=0; i < projectiles.length; i++) {
    for (Enemy e : enemies) {
      if (e.hasCollided(projectiles[i].getPosition())) {
        hits++;
        level = hits / 10;
        e.setLevel(level);
        e.destroy();
        projectiles[i] = new Projectile();
      }
    }
    projectiles[i].updatePosition();
    projectiles[i].display();
  }
}

void checkEnemyInteractions() {
  for (Enemy e : enemies) {
    e.display();
    e.target(player.getPosition(), player.getSize());
    if (player.hasCollided(e.getPosition(), e.getSize())) if (health>0) health--;
    if (e.getSize() == 0) {
      e.setRandomSize();
      e.setRandomPosition();
      e.setSpeed(aggressivity);
    }
    if (bomb.hasCollided(e.getPosition())) {
      hits++;
      level = hits / 10;
      e.setLevel(level);
      e.destroy();
    }
    if (hits % boxForHits == 0 && !boxCreated && hits != 0 && boxIndex < numBoxes) {
      boxes[boxIndex] = new Box();
      boxes[boxIndex].setRandomPosition();
      boxes[boxIndex].display();
      boxIndex++;
      boxCreated = true;
    }
    if (hits % boxForHits != 0) {
      boxCreated = false;
    }
  }
}

void checkGameOver() {
  if (health == 0) {
    soundDeath.play();
    allScores[gameNumber] = new Score(hits, difficulty);
    gameNumber++;
    showGameOverOptionsDialog();
  }
}

//---------- MAIN ----------//

void setup() {
  // Window settings
  size(1280, 720);
  surface.setLocation(0, 0);

  // Background, font and sound settings
  backgroundImage = loadImage("background.png");
  customFont = createFont("Orbitron-VariableFont_wght.ttf", 32); // create a font object from the file "MyFont.ttf"
  textFont(customFont); // set the font for text
  soundBomb = new SoundFile(this, "bomb.mp3");
  soundProjectile = new SoundFile(this, "projectile.mp3");
  soundDeath = new SoundFile(this, "death.mp3");

  /* Asking for a name player and showing the instructions
   when the game is launched for the first time */
  showPlayerCreationDialog();
  showInstructionsDialog();
}

void draw() {
  /* Set the difficulty given by user input and start the game
   with the settings related to the difficulty chosen */

  if (!gameOn) {
    chooseDifficultyDialog();
    initGame();
    gamePlayed++;
    gameOn = true;
  }
  // All modules related to the game that need to be drawn for each frame
  if (gameOn) {
    GUI();
    checkPressedKeys();
    player.display();
    player.updatePosition();
    player.displayAim();
    bomb.display();
    bomb.update();
    checkSpawnBoxes();
    checkEnemyInteractions();
    checkProjectileInteractions();
    checkGameOver();
  }
}
