public class Score {

  /* Score is calculated by multiplying hits per difficulty coefficient.
   That means that hits made in the Easy mode are not worth the same as
   Medium   or Hard mode. It's a mechanism that rewards the player based
   on the difficulty as well as the hit enemies */

  //---------- FIELDS ----------//

  private String difficulty;
  private float difficultyCoefficient;
  private int value;

  //---------- CONSTRUCTORS ----------//

  public Score(int hits, String difficulty) {
    this.difficulty = difficulty;
    setDifficultyCoefficient(difficulty);
    this.value = (int)(hits * difficultyCoefficient);
  }

  //---------- GETTERS/SETTERS ----------//

  public int getValue() {
    return value;
  }

  public String getDifficulty() {
    return difficulty;
  }

  private void setDifficultyCoefficient(String difficulty) {
    if (difficulty == "Easy") difficultyCoefficient = 0.8;
    if (difficulty == "Medium") difficultyCoefficient = 1;
    if (difficulty == "Hard") difficultyCoefficient = 1.2;
  }
}
