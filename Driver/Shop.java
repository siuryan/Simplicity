/**
 class Shop
 Contains the data for instances of Airplanes and Cities that can be purchased.
 */
public class Shop {

  // to be bought Airplanes
  public static Airplane[] airplanes = {
    // name, range, speed, capacity, price, fuelCapacity, currentCity
    new Airplane( "Old plane", 500, 30, 10, 500000, 50, null), 
    new Airplane( "Boeing 787", 300, 100, 25, 3000000, 100, null), 
    new Airplane( "Airbus A380", 300, 100, 50, 4200000, 100, null)
  };

  // to be bought Cities
  // population -- 1000:1 Real:In Game
  public static City[] cities = {
    new City("New York", 8491, 1000, 10000), 
    new City("Los Angeles", 3929, 1000, 10000), 
    new City("Chicago", 2722, 1000, 10000), 
    new City("Houston", 2296, 1000, 5000), 
    new City("Philadelphia", 1567, 1000, 10000), 
    new City("Phoenix", 1563, 1000, 5000), 
    new City("San Francisco", 852, 1000, 10000), 
    new City("Washington DC", 672, 1000, 5000), 
    new City("Boston", 656, 1000, 5000)
  };

  /**
   Removes a random City from the Shop and returns it.
   */
  public static City popCity() {
    int index = (int)(Math.random()*cities.length);
    City city = cities[index];
    removeCity( index );
    return city;
  }

  /**
   Removes a City in the specified index in the Shop.
   */
  public static void removeCity( int index ) {
    City[] copy = new City[cities.length-1];
    for (int i = 0; i < index; i++) {
      copy[i] = cities[i];
    }
    for (int i = index+1; i < cities.length; i++) {
      copy[i-1] = cities[i];
    }
    cities = copy;
  }

  /**
   Makes a copy of an Airplane and returns that copy.
   */
  public static Airplane buy(Airplane original) {
    Airplane copy = new Airplane(original.getAirplaneName(), original.getRange(), original.getSpeed(), original.getCapacity(), original.getPrice(), original.getFuelCapacity(), null );
    return copy;
  }
}