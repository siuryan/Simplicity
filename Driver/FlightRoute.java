/**
 class FlightRoute
 Represents the flight route between two cities in the game.
 */
public class FlightRoute {

  // Instance vars
  private City _departCity;
  private City _arriveCity;
  private double _distance;
  private int _profit;
  private Airplane _plane;
  private int _tickPrice;
  private long _timeStart, _timeEnd;

  // Default constructor
  public FlightRoute() {
    _departCity = null;
    _arriveCity = null;
    _distance = 0;
    _profit = 0;
    _plane = null;
    _tickPrice = 0;
    _timeStart = 0;
    _timeEnd = 0;
    _timeStart = 0;
  }

  // Overloaded construtor
  public FlightRoute( City departCity, City arriveCity, Airplane plane) {
    _departCity = departCity;
    _arriveCity = arriveCity;
    _plane = plane;
    updateDistance();
    _tickPrice = autoCalcPrice();
    updateProfit();
    updateTime();
  }

  // Accessors
  public City getDeparture() { 
    return _departCity;
  }
  public City getArrival() { 
    return _arriveCity;
  }
  public double getDistance() { 
    return _distance;
  }
  public int getProfit() { 
    return _profit;
  }
  public Airplane getAirplane() { 
    return _plane;
  }
  public int getTicketPrice() { 
    return _tickPrice;
  }
  public long getEndTime() { 
    return _timeEnd;
  }
  public long getStartTime() { 
    return _timeStart;
  }

  // Mutators
  public City setDeparture( City newCity ) {
    City foo = _departCity;
    _departCity = newCity;
    updateDistance();
    updateProfit();
    return foo;
  }
  public City setArrival( City newCity ) {
    City foo = _arriveCity;
    _arriveCity = newCity;
    updateDistance();
    updateProfit();
    return foo;
  }
  public Airplane setAirplane( Airplane newPlane ) {
    Airplane foo = _plane;
    _plane = newPlane;
    updateProfit();
    return foo;
  }
  public int setTicketPrice( int newPrice ) {
    int foo = _tickPrice;
    _tickPrice = newPrice;
    updateProfit();
    return foo;
  }

  // helper method for finding the distance between the departure and arrival cities using their coords
  private void updateDistance() {
    double x1 = getDeparture().getXcor();
    double y1 = getDeparture().getYcor();
    double x2 = getArrival().getXcor();
    double y2 = getArrival().getYcor();
    _distance = Math.sqrt( (y2-y1)*(y2-y1) + (x2-x1)*(x2-x1) );
  }

  // calculates and updates the profit from flying this route
  // ALGO: uses population of the two cities to get the # of passengers, then multiplies this by the ticket price
  // currently uses an automatic price setter for the ticket price
  private void updateProfit() {

    // insert formula for calculating route profit (using city pop?)
    /*
	_profit = getDeparture().getPop() + getArrival().getPop();
     	if (_profit > getAirplane().getCapacity()) {
     	    _profit = getAirplane().getCapacity();
     	}
     	_profit = _profit - (int)(getDistance() / 30);
     	*/

    // max is 100
    int passengers = (int)Math.sqrt((getDeparture().getPop()+getArrival().getPop())/2);
    if (passengers > getAirplane().getCapacity()) {
      passengers = getAirplane().getCapacity();
    }
    _profit = passengers*_tickPrice;
  }

  // returns distance as ticket price
  private int autoCalcPrice() {
    return (int)(getDistance());
  }

  // finds and updates the time when the flight will start and end (in milliseconds since January 1, 1970)
  private void updateTime() {
    long currentTime = System.currentTimeMillis();
    _timeStart = currentTime;
    _timeEnd = currentTime + (long)((getDistance() / getAirplane().getSpeed()) * 1000 * 60); // to convert to min
  }

  /**
   Calculates the time remaining in the flight.
   returns long - milliseconds remaining
   */
  public long getTimeRem() {
    long currentTime = System.currentTimeMillis();
    return (_timeEnd - currentTime)/1000;
  }

  /**
   Calculates the time elapsed in the flight.
   returns long - milliseconds elapsed
   */
  public long getTimeElapsed() {
    long currentTime = System.currentTimeMillis();
    return (currentTime - _timeStart)/1000;
  }

  /**
   Calculates the total time of the flight.
   returns long - time in milliseconds of flight
   */
  public long totalTime() {
    return (_timeEnd - _timeStart)/1000;
  }

  public String toString() {
    if (getAirplane().getStatus() != 1) {
      return "Flight from " + getDeparture() + " to " + getArrival() +
        ". Distance: " + (int)getDistance() + ". Profit: " + getProfit() + ".\n"
        + "Airplane: " + getAirplane().toString();
    } else {
      return "Flight from " + getDeparture() + " to " + getArrival() +
        ". Distance: " + (int)getDistance() + ". Profit: " + getProfit() + ".\n"
        + "Airplane: " + getAirplane().toString() + "\nTime remaining: " +
        getTimeRem() + "s";
    }
  }
}