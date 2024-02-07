/* Reflection
 
 Name: Giacomo Cavarretta
 Student Number: 20104117
 
 Link to your development Blog on Blogger:
 https://prog-a2-giacomo-cavarretta.blogspot.com/
 
 Link to Video on YouTube:
 https://www.youtube.com/watch?v=4URhYVZ38nk
 
 
 Part A - Mark (11 /11)
 -----------------------------
 
 Inclusion of completed:
 A1 - Readme (1)
 A2 - Reflection (4)
 A3 - Video (4)
 A4 - Blog (2)
 
 These are all created to spec, so I am awarding myself 11 marks
 
 
 Part B - Mark (4 /4)
 -----------------------------
 
 B1 - Comments (1)
 B2 - Indentation (1)
 B3 - Naming (1)
 B4 - Structure of code (1)
 
 Example of multiline comment on line [Main]line 17,18,19,20
 Example of line comment on [Main]line 24
 
 These are all created to spec, so I am awarding myself 4 marks
 
 
 Part C - Mark (4 /5)
 -----------------------------
 Use of standard programming control constructs
 (if, loop, nesting):
 
 * if statements
 
 [Main]line 97 is an IF to check if key w or W has been pressed
 [Main]line 124 is an IF to check if key w or W has been released
 [Enemy]line 135 is an IF with multiple branches for determing if the closest point on a line segment is inside or outside the segment and calculates the distance accordingly
 [Main]line 283 is a SWITCH that checks what difficulty has been chosen by the input given by the user
 
 * Loops
 
 FOR loop used on:
 [Main]line 339 to get the higher score in the array and to show on the dialog the games played and their score
 
 WHILE loop used on:
 [Main]line 375 to initialize the enemies array
 
 DO WHILE loop use on:
 [Main]line 382 to initialize the projectiles array
 
 FOR EACH loops used on:
 [Main]line 415 to display every box that has been created (not null) and check its collision with the player
 [Main]line 443 to update the enemies movements and looking for collisions with the player and the bombs
 
 NESTED loop used on:
 [Main]line 427 is the outer loop that iterates the projectiles array
 [Main]line 428 to the inner nested loop that iterates the enemies array, looking for collision for each projectile of the outer loop and settings hits when it occurs
 
 I have multiple examples of if statements and loops but not nesting so I give myself 4/5
 
 
 Part D1 - Mark (10 /10)
 -----------------------------
 
 Window size 1280x720 [Main]line 484
 Sounds [Main]line 491,492,493
 Font [Main]line 489
 Images [Main]line 488, [Box]line 14, [Enemy]line 26, [Player]line 20
 Life [Main]line 397
 Live score [Main]line 400
 Highscore table [Main]line 335
 
 Player can fire multiple projectiles and throw a bomb
 Multiple collision detection systems
 
 My game demonstrates use collision detection, scoring, live and the game resets correctly to play a new game.
 Therefore I score 10/10
 
 
 Part D2 - Mark (8 /10)
 -----------------------------
 I have a key handler set up on line 171
 it handles:
 - left (A)
 - right (D)
 - up (W)
 
 Additional features:
 - bomb (space bar)
 - run (shift)
 
 It also handles the cursor left key to fire
 
 I have working key handler, cursor keys too, and an additional 2 keys so I give myself 8/10
 
 
 Part D3 - Mark (10 /10)
 -----------------------------
 Collision detection BESPOKE METHODS defined in main program file:
 
 Collision detection Bomb - Enemy [Bomb]line 59. Called on [Main]line 452
 Collision detection Enemy - Projectile [Enemy]line 121. Called on [Main]line 429
 Collision detection Box - Player [Box]line 46. Called on [Main]line 418
 Collision detection Player - Enemy [Player]line 120. Called on [Main]line 446
 
 I have the basic collision detection between 2 objects
 I am also checking edge conditions, and I have 4 other collision detections therefor I am scoring myself 10/10
 
 
 -----------------------------
 Part E USER DEFINED CLASSES
 -----------------------------
 
 Part E1 - Mark (10 /10)
 -----------------------------
 Excluding the player class and the main program, I have 3 other classes defined in their own files/tabs:
 
 1- Bomb
 2- Box
 3- Enemy
 4- Key
 5- Projectile
 6- Score
 
 Each of these user-defined classes has appropriate fields, constructors, getters, setters. These are highlighted as follows:
 
 1.Bomb CLASS
 Fields begin line: 5
 Constructors begin line: 12
 OVERLOADED Constructors: 12, 18
 Getters/Setters begin line: 26
 Bespoke methods begin line: 51
 
 2.Box CLASS
 Fields begin line: 5
 Constructors begin line: 11
 Getters/Setters begin line: 19
 Bespoke methods begin line: 36
 
 3.Enemy CLASS
 Fields begin line: 5
 Constructors begin line: 13
 OVERLOADED Constructors: 13, 21
 Getters/Setters begin line: 31
 Bespoke methods begin line: 89
 
 4.Key CLASS
 Fields begin line: 6
 Constructors begin line: 12
 Getters/Setters begin line: 19
 
 5.Projectile CLASS
 Fields begin line: 5
 Constructors begin line: 14
 OVERLOADED Constructors: 14, 22
 Getters/Setters begin line: 32
 Bespoke methods begin line: 102
 
 6. Score CLASS
 Fields begin line: 10
 Constructors begin line: 16
 Getters/Setters begin line: 24
 
 I have documented 6 classes and 3 of them include overloaded constructors therefore I am scoring 10/10
 
 
 Part E2 - Mark (6 /10)
 -----------------------------
 
 Class bespoke methods i.e. private helper methods:
 
 1.Bomb CLASS
 line 51 takes in 0 parameters and returns NO value
 line 59 takes in 1 parameter and returns a value
 
 2.Box CLASS
 line 38 takes in 0 parameters and returns NO value
 line 46 takes in 2 parameters and returns a value
 
 3.Enemy CLASS
 line 91 takes in 2 parameters and returns NO value
 line 113 takes in 0 parameters and returns NO value
 line 121 takes in 1 parameter and returns a value
 line 154 takes in 0 parameters and returns NO value
 
 4. Player CLASS
 line 79 takes in 2 parameters and returns NO value
 line 90 takes in 2 parameters and returns NO value
 line 114 takes in 2 parameters and returns NO value
 line 120 takes in 2 parameters and returns a value
 
 5.Projectile CLASS
 line 102 takes in 0 parameters and returns NO value
 line 107 takes in 0 parameters and returns NO value
 line 115 takes in 0 parameters and returns NO value
 
 Private help methods for 3 classes are highlighted showing multiple examples of Methods with no return values, return values, parameters. I am awarding myself 10/10
 
 
 Part E3 - Mark (10 /10)
 -----------------------------
 
 - The user-defined class(es) are USED in an appropriate manner
 
 multiple declarations of user defined classes are USED:
 [Main]line 22, to declare and initialise a Projectile array
 [Main]line 25, to declare and initialise a Score array
 [Main]line 26, to declare a Box array
 [Main]line 27, to declare an Enemy array
 [Main]line 28, to declare a Bomb variable
 [Main]line 29, to declare a Player variable
 
 getters/setters are USED on:
 [Main]line 97, to get the isActive field value
 [Main]line 98, to set the isDisabled field value
 [Main]line 183, to get the acceleration field value
 [Main]line 183, to get the isActive field value
 [Main]line 186, to set the isDisabled field value
 [Main]line 198, to set the speed field value
 [Main]line 199, to set the acceleration field value
 
 default constructors USED on:
 [Main]line 86, to call the default constructor
 [Main]line 372, to call the default constructor
 [Main]line 376, to call the default constructor
 [Main]line 383, to call the default constructor
 [Main]line 409, to call the default constructor
 
 overloaded constructors USED on:
 
 [Main]line 228, to call an overload constructor
 [Main]line 238, to call an overload constructor
 [Main]line 369, to call an overload constructor
 [Main]line 474, to call an overload constructor
 
 
 I showed exampled of calling getters, setters, default and overload constructors and
 I declared and initialized variables and arrays of objects. I am awarding myself 10/10
 
 ------------------------
 PART F - DATA STRUCTURES
 ------------------------
 
 Part F1 - Mark (8 /10)
 -----------------------------
 
 Box[] boxes
 declare on [Main]line 26
 initialised on [Main]line 370 where numBoxes value is filled by user input
 (when the method chooseDifficultyDialog() declared on [Main]line 280 is called)
 used on [Main]line 409 to store an instance of Box class
 
 Enemy[] enemies
 declare on [Main]line 27
 initialised on [Main]line 371 where numEnemies value is filled by user input
 (when the method chooseDifficultyDialog() declared on [Main]line 280 is called)
 used on [Main]line 376 to store an instance of Enemy class
 used on [Main]line 377 to set a value for an instance of Enemy class
 
 I used multiple array examples where the length of the array is defined by the user
 so I give myself 8/10
 
 Part F2 - Mark (6 /10)
 -----------------------------
 - Calculations performed on the information stored
 
 [Main]line 339 I used a loop to find the higher score in the array allScores
 without updating the array so I award myself 6/10
 
 
 TOTAL MARK = 87
 
 
 FINAL CHECK:
 I have checked the constraints and I am not breaking any constraints
 */
