/**
 class Airplane
 Represents an airplane in the game.
 */
public class Airplane {

  // Instance vars
  private String _name;
  private int _range;
  private int _speed;
  private int _capacity;
  private int _price;
  private int _fuelCapacity;
  private int _status; // 0 for not flying, 1 for flying
  private City _currCity;
  private double _efficiency;
  private int _tank;

  // Default constructor
  public Airplane() {
    _name = "";
    _range = 0;
    _speed = 0;
    _capacity = 0;
    _price = 0;
    _fuelCapacity = 0;
    _status = 0;
    _currCity = null;
    _efficiency = 0;
    _tank = 0;
  }

  // Overloaded constructor
  public Airplane( String name, int range, int speed, int capacity, int price, int fuelCapacity, City currCity ) {
    _name = name;
    _range = range;
    _speed = speed;
    _capacity = capacity;
    _price = price;
    _fuelCapacity = fuelCapacity;
    _status = 0;
    _currCity = currCity;
    _efficiency = (double) fuelCapacity / range;
    _tank = _fuelCapacity;
  }

  // Accessors
  public String getAirplaneName() { 
    return _name;
  }
  public int getRange() { 
    return _range;
  }
  public int getSpeed() { 
    return _speed;
  }
  public int getCapacity() { 
    return _capacity;
  }
  public int getPrice() { 
    return _price;
  }
  public int getFuelCapacity() { 
    return _fuelCapacity;
  }
  public int getStatus() { 
    return _status;
  }
  public City getCity() { 
    return _currCity;
  }
  public double getEfficiency() {
    return _efficiency;
  }
  public int getTank() {
    return _tank;
  };

  // Mutators
  public int setStatus( int status ) {
    int foo = _status;
    _status = status;
    return foo;
  }
  public City setCity( City city ) {
    City foo = _currCity;
    _currCity = city;
    return foo;
  }
  public int setTank( double distance ) {
    _tank = (int) (_tank - (_efficiency * distance)); 
    return _tank;
  }
  public String toString() {
    return getAirplaneName() + ". Range: " + getRange() + ". Speed: " + getSpeed() +
      ". Capacity: " + getCapacity() + ". Current city: " + getCity() +
      ". Status: " + getStatus() + 
      ". Fuel: " + getTank() + ".";
  }
}