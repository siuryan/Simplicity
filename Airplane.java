public class Airplane {

    private String name;
    private int _range;
    private int _speed;
    private int _capacity;
    private int _price;
    private int _fuelCapacity;
    private int _status; // 0 for not flying, 1 for flying

    public Airplane() {
	_name = "";
	_range = 0;
	_speed = 0;
	_capacity = 0;
	_price = 0;
	_fuelCapacity = 0;
	_status = 0;
    }

    public Airplane( String name, int range, int speed, int capacity,
		     int price, int fuelCapacity ) {
	_name = name;
	_range = range;
	_speed = speed;
	_capacity = capacity;
	_price = price;
	_fuelCapacity = fuelCapacity;
	_status = 0;
    }

    public String getName() {
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

    public int setStatus( int status ) {
	int foo = _status;
	_status = status;
	return foo;
    }
}
