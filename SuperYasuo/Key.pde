public class Key {

  //---------- FIELDS ----------//

  // To fire an action while the key is pressed
  private boolean isActive;
  // To avoid that a key can fire repeated actions while it kept being pressed
  private boolean isDisabled;

  //---------- CONSTRUCTORS ----------//

  public Key() {
    setIsActive(false);
    setIsDisabled(false);
  }

  //---------- GETTERS/SETTERS ----------//

  public boolean getIsDisabled() {
    return isDisabled;
  }

  public void setIsDisabled(boolean value) {
    isDisabled = value;
  }

  public boolean getIsActive() {
    return isActive;
  }

  public void setIsActive(boolean value) {
    isActive = value;
  }
}
