public class City {

  private int _pop;
  private int _xcor;
  private int _ycor;
  private String _name;

  public City() {
    _name = "";
    _xcor = 0;
    _ycor = 0;
    _pop = 0;
  }

  public City( String n, int pop, int screenSize ) {
    _xcor = (int)(Math.random()*(Constants.WIDTH-Constants.MENU_MAP_DIVIDE)+Constants.MENU_MAP_DIVIDE);
    _ycor = (int)(Math.random()*Constants.HEIGHT);
    _pop = pop;
    _name = n;
  }

  public String getName() {
    return _name;
  }

  public int getPop() {
    return _pop;
  }

  public int getXcor() {
    return _xcor;
  }

  public int getYcor() {
    return _ycor;
  }

  public String toString() {
    return _name + " (" + getXcor() + "," + getYcor() + ")";
  }
}