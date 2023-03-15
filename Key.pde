public class Key {
  //------------//
  //   FIELDS   //
  //------------//

  private String name;
  private boolean active;
  private boolean once;

  //------------------//
  //   CONSTRUCTORS   //
  //------------------//

  Key(String n, boolean o) {
    this.name=n;
    this.active=false;
    this.once=o;
  }

  //------------------//
  //   GETS AND SETS  //
  //------------------//

  public String getname() {
    return this.name;
  }

  public boolean getOnce() {
    return this.once;
  }

  public void setOnce(boolean value) {
    this.once=value;
  }

  public void setActive(boolean value) {
    this.active=value;
  }
}
