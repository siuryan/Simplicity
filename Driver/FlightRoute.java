public class FlightRoute {

    private City _departCity;
    private City _arriveCity;
    private double _distance;
    private int _profit;
    private Airplane _plane;
    private int _tickPrice;
    
    public FlightRoute() {
	_departCity = null;
	_arriveCity = null;
	_distance = 0;
	_profit = 0;
	_plane = null;
	_tickPrice = 0;
    }

    public FlightRoute( City departCity, City arriveCity, Airplane plane) {
	_departCity = departCity;
	_arriveCity = arriveCity;
	_plane = plane;
	updateDistance();
	_tickPrice = autoCalcPrice();
	updateProfit();
    }

    public City getDeparture() { return _departCity; }
    public City getArrival() { return _arriveCity; }
    public double getDistance() { return _distance; }
    public int getProfit() { return _profit; }
    public Airplane getAirplane() { return _plane; }
    public int getTicketPrice() { return _tickPrice; }

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

    private void updateDistance() {
	double x1 = getDeparture().getXcor();
	double y1 = getDeparture().getYcor();
	double x2 = getArrival().getXcor();
	double y2 = getArrival().getYcor();
	_distance = Math.sqrt( (y2-y1)*(y2-y1) + (x2-x1)*(x2-x1) );
    }

    private void updateProfit() {
	// insert formula for calculating route profit (using city pop?)
	/*
	_profit = getDeparture().getPop() + getArrival().getPop();
	if (_profit > getAirplane().getCapacity()) {
	    _profit = getAirplane().getCapacity();
	}
	_profit = _profit - (int)(getDistance() / 30);
	*/
	int passengers = Math.abs(getDeparture().getPop()-getArrival().getPop())/2;
	if (passengers > getAirplane().getCapacity()) {
	    passengers = getAirplane().getCapacity();
	}
	_profit = passengers*_tickPrice;
    }


    public int autoCalcPrice() {
	return (int)(getDistance()/100);
    }

    public String toString() {
	return "Flight from " + getDeparture() + " to " + getArrival() +
	    ". Distance: " + getDistance() + ". Profit: " + getProfit() + ".\n"
	    + "Airplane:\n" + getAirplane().toString();
    }
}