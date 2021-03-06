import java.util.ArrayList;
/**
 class Shop
 Contains the data for instances of Airplanes and Cities that can be purchased.
 */

public class Shop {

  // to be bought Airplanes
  public static Airplane[] airplanes = {
    // name, range, speed, capacity, price, fuelCapacity, currentCity
    new Airplane( "Old plane", 500, 30, 10, 500000, 50, null), 
    new Airplane( "Boeing 747", 400, 75, 35, 1000000, 75, null),
    new Airplane( "Airbus A320", 400, 75, 40, 1500000, 75, null),
    new Airplane( "Boeing 787", 300, 100, 50, 3000000, 100, null), 
    new Airplane( "Airbus A380", 300, 100, 75, 4200000, 100, null),
    new Airplane( "Air Force One", 1000, 150, 15, 10000000, 500, null)
  };

  // to be bought Cities
  // population -- 1000:1 Real:In Game
  public static City[] cities = {
    new City("New York", 8491), 
    new City("Los Angeles", 3929), 
    new City("Chicago", 2722), 
    new City("Houston", 2296), 
    new City("Philadelphia", 1567), 
    new City("Phoenix", 1563), 
    new City("San Francisco", 852), 
    new City("Washington DC", 672), 
    new City("Dallas", 1281),
    new City("San Antonio", 1437)
  };

  /**
   Removes a random City from the Shop and returns it.
   */
  public static City popCity() {
    int index = (int)(Math.random()*cities.length);
    City city = cities[index];
    city.setStatus(0);
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
   <insert stuff here>
   */
  public static Airplane[] toBeFilled(ArrayList<Airplane> list) {
    ArrayList<Airplane> eh = new ArrayList<Airplane>(); 
    for (int i = 0; i < list.size(); i ++) {
      if (list.get(i).getBought() && !list.get(i).full()) {
        eh.add(list.get(i));
        list.get(i).setState(2);
      }
    }
    Airplane[] ret = new Airplane[eh.size()];
    for (int i = 0; i < eh.size(); i ++) {
      ret[i] = eh.get(i);
    }
    return ret;
  }

  /**
   Makes a copy of an Airplane and returns that copy.
   */
  public static Airplane buy(Airplane original) {
    Airplane copy = new Airplane(original.getAirplaneName(), original.getRange(), original.getSpeed(), original.getCapacity(), original.getPrice(), original.getFuelCapacity(), null ); 
    copy.setBought(); 
    return copy;
  }
}