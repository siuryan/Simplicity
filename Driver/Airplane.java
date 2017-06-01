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
  private boolean _bought;
  private int _state; // 1 for bought, 2 for to be refueled

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
    _bought = false;
    _state = 0;
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
    _bought = false;
    _state = 0;
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
  }
  public boolean getBought(){
    return _bought;
  }
  public int getCost(){
     return (_fuelCapacity - _tank) * 10; 
  }

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
  public void setState( int n ){
     _state = n; 
  }
  public void setBought(){
     _bought = true; 
     setState(1);
  }
  
  /**
   Returns whether or not the airplane has a full tank of fuel.
   */
  public boolean full(){
     return _tank == _fuelCapacity; 
  }
  /**
   Sets airplane's fuel back to maximum.
   */
  public void refuel(){
     _tank = _fuelCapacity; 
  }
  
  public String toString() {
    if (_state == 1){
    return getAirplaneName() + ". Range: " + getRange() + ". Speed: " + getSpeed() +
      ". Capacity: " + getCapacity() + ". Status: " + getStatus() + 
      ". Fuel: " + getTank() + ".";
    }
    else if (_state == 2){
      return getAirplaneName() + ". Fuel Remaining: " + getTank() +
      " out of " + _fuelCapacity + ". Cost to refuel: $" + getCost();
    }
    return getAirplaneName() + " . Range: " + getRange() + ". Speed: " + getSpeed() +
      ". Capacity: " + getCapacity() + ". Current city: " + getCity() +
      ". Status: " + getStatus() + 
      ". Price: " + getPrice() + ".";
    
  }
}