public class Shop {

  public static Airplane[] airplanes = {
    // name, range, speed, capacity, price, fuelCapacity, currentCity
    new Airplane( "Old plane", 500, 30, 10, 500000, 50, null), 
    new Airplane( "Boeing 787", 300, 100, 25, 3000000, 100, null), 
    new Airplane( "Airbus A380", 300, 100, 50, 4200000, 100, null)
  };
  /*
    public static String[] cityNames = {
   	"New York", "Los Angeles", "San Francisco", "Houston", "Boston",
   	"Washington DC"
   };
   */

  //population -- 1000:1 Real:In Game
  public static City[] cities = {
    new City("New York", 8491, 1000), 
    new City("Los Angeles", 3929, 1000), 
    new City("Chicago", 2722, 1000), 
    new City("Houston", 2296, 1000), 
    new City("Philadelphia", 1567, 1000), 
    new City("Phoenix", 1563, 1000), 
    new City("San Francisco", 852, 1000), 
    new City("Washington DC", 672, 1000), 
    new City("Boston", 656, 1000)
  };

  public static City popCity() {
    int index = (int)(Math.random()*cities.length);
    City city = cities[index];
    removeCity( index );
    return city;
  }

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
}