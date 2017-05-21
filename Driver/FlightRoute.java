public class FlightRoute {

    private City _departCity;
    private City _arriveCity;
    private double _distance;
    private int _earnedMoney;
    private Airplane _plane;
    
    public FlightRoute() {
	_departCity = null;
	_arriveCity = null;
	_distance = 0;
	_earnedMoney = 0;
	_plane = null;
    }

    public FlightRoute( City departCity, City arriveCity, Airplane plane) {
	_departCity = departCity;
	_arriveCity = arriveCity;
	_plane = plane;
	updateDistance();
    }

    public City getDeparture() { return _departCity; }
    public City getArrival() { return _arriveCity; }
    public double getDistance() { return _distance; }
    public int getMoney() { return _earnedMoney; }
    public Airplane getAirplane() { return _plane; }

    public City setDeparture( City newCity ) {
	City foo = _departCity;
	_departCity = newCity;
	updateDistance();
	return foo;
    }

    public City setArrival( City newCity ) {
	City foo = _arriveCity;
	_arriveCity = newCity;
	updateDistance();
	return foo;
    }

    public Airplane getAirplane( Airplane newPlane ) {
	Airplane foo = _plane;
	_plane = newPlane;
	updateMoney();
	return foo;
    }

    private void updateDistance() {
	double x1 = getDeparture().getXcor();
	double y1 = getDeparture().getYcor();
	double x2 = getArrival().getXcor();
	double y2 = getArrival().getYcor();
	_distance = Math.sqrt( (y2-y1)*(y2-y1) + (x2-x1)*(x2-x1) );
	updateMoney();
    }

    private void updateMoney() {
	// insert formula for calculating route profit (using city pop?)
    }
}
