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
  private int _price;

  // Default constructor
  public City() {
    _name = "";
    _xcor = 0;
    _ycor = 0;
    _pop = 0;
    _price = 0;
  }

  // Overloaded constructor
  public City( String n, int pop, int screenSize, int price ) {
    // set xcor and ycor to random values inside the playing map
    _xcor = (int)(Math.random()*(Constants.WIDTH-Constants.MENU_MAP_DIVIDE)+Constants.MENU_MAP_DIVIDE);
    _ycor = (int)(Math.random()*Constants.HEIGHT);
    _pop = pop;
    _name = n;
    _price = price;
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
  
  public int getPrice(){
    return _price;    
  }

  public String toString() {
    return _name + " (" + getXcor() + "," + getYcor() + ")  " + "Price: " + _price;
  }
}