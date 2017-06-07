/**
 class City
 Represents a city in the game.
 */
public class City {

  // Instance vars
  private int _pop;
  private int _xcor;
  private int _ycor;
  private String _name;
  private int _profit;
  private int _status; //true if bought, false otherwise

  // Default constructor
  public City() {
    _name = "";
    _xcor = 0;
    _ycor = 0;
    _pop = 0;
    _status = 0;
    _profit = 0;
  }

  // Overloaded constructor
  public City( String n, int pop ) {
    // set xcor and ycor to random values inside the playing map
    _xcor = (int)(Math.random()*(Constants.WIDTH-Constants.MENU_MAP_DIVIDE)+Constants.MENU_MAP_DIVIDE);
    _ycor = (int)(Math.random()*Constants.HEIGHT);
    _pop = pop;
    _name = n;
    _status = 0;
    _profit = 0;
  }

  // Accessors
  public String getCityName() { 
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
  public int getPrice() {
    return _pop * 100;
  }

  // Mutators
  public void setStatus( int n ) {
    _status = n;
  }

  public void setProfit( int n ) {
    _profit = n;
  }

  public String toString() {
    if (_status == 0) {
      return _name + " (" + getXcor() + "," + getYcor() + ")";
    } else if (_status == 1) {
      return _name + " (" + getXcor() + "," + getYcor() + ") Price: " + getPrice();
    }
    return _name + " (" + getXcor() + "," + getYcor() + ") Estimated profit: " + _profit;
  }
}