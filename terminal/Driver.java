import java.io.*;
import java.util.*;

public class Driver {

  public static final int SCREEN_SIZE = 600;

  private static InputStreamReader isr;
  private static BufferedReader in;

  private static ArrayList<Airplane> airplanes;
  private static ArrayList<City> cities;
  private static ArrayList<FlightRoute> flights;

  private static int money;

  public static void main( String[] args ) {

    isr = new InputStreamReader( System.in );
    in = new BufferedReader( isr );
    //100:1 Real:In Game
    money = 5000000;

    airplanes = new ArrayList<Airplane>();

    //if we want to give a free plane to start with
    airplanes.add(Shop.airplanes[0]);

    cities = new ArrayList<City>();
    for (int i = 0; i < 2; i++) {
      cities.add(Shop.popCity());
    }

    //if free plane given
    airplanes.get(0).setCity( cities.get(0) );

    flights = new ArrayList<FlightRoute>();

    String planeMenu = planeMenu();
    String cityMenu = cityMenu();

    while (true) {
      String mode = prompt( "\nMENU:\n" +
        "0: Possible flight routes\n" +
        "1: Your airplanes\n" +
        "2: See current flights\n" +
        "3: Shop\n" +
        "4: View your cities\n" +
        "You have $" + money + ".");

      if ( Integer.valueOf(mode) == 0 ) {
        ArrayList<FlightRoute> routes = possibleFlights();
        int routeNum = 0;
        if (routes.size() > 0) {
          for (FlightRoute r : routes) {
            System.out.println("(" + routeNum + ") " + r);
            System.out.println();
            routeNum++;
          }
          String choice = prompt( "\nCHOICES:\n" +
            "0: Start a flight\n" +
            "1: Return to menu\n");
          if (Integer.valueOf(choice) == 0) {
            String in = prompt("Choose a route: ");
            FlightRoute route = routes.get(Integer.valueOf(in));
            flights.add(route);
            route.getAirplane().setStatus(1);
            money += route.getProfit();
          }
        } else {
          System.out.println( "Sorry, there are no possible routes." );
        }
      } else if ( Integer.valueOf(mode) == 1 ) {
        if (airplanes.size() == 0) {
          System.out.println( "Sorry, you have no airplanes. You can buy one from the shop." );
        } else {
          updateFlights();
          for (Airplane a : airplanes) {
            System.out.println(a);
          }
        }
      } else if ( Integer.valueOf(mode) == 2) {
        if (flights.size() == 0) {
          System.out.println( "Sorry, you have no flights." );
        } else {
          updateFlights();
          for (FlightRoute r : flights) {
            System.out.println(r);
            System.out.println();
          }
        }
      } else if ( Integer.valueOf(mode) == 3 ) {
        while (true) {
          String shop = prompt( "\nSHOP:\n" +
            "0: Airplanes\n" +
            "1: Unlock new cities\n" +
            "2: Return to menu\n" +
            "You have $" + money + ".");
          if (Integer.valueOf(shop) == 0) {
            String choicePlane = prompt(planeMenu +
              "You have $" + money + ".");
            for (int index = 0; index < Shop.airplanes.length; index++) {
              if (Integer.valueOf(choicePlane) == index) {
                if (money > Shop.airplanes[index].getPrice()) {
                  money -= Shop.airplanes[index].getPrice();
                  airplanes.add(Shop.airplanes[index]);
                  airplanes.get(airplanes.size()-1).setCity(cities.get(0));
                } else {
                  System.out.println("Not enough money");
                }
                break;
              }
            }
          } else if (Integer.valueOf(shop) == 1) {
            // check if no cities left
            if (Shop.cities.length > 0) {
              String choiceCity = prompt(cityMenu +
                "You have $" + money + ".");
              for (int index = 0; index < Shop.cities.length; index++) {
                if (Integer.valueOf(choiceCity) == index) {
                  if (money > Shop.cities[index].getPop()*100) {
                    money -= Shop.cities[index].getPop()*100;
                    cities.add(Shop.cities[index]);
                    Shop.removeCity( index );
                    cityMenu = cityMenu();
                  } else {
                    System.out.println("Not enough money");
                  }
                  break;
                }
              }
            } else {
              System.out.println("No more new cities");
            }
          } else {
            break;
          }
        }
      } else if ( Integer.parseInt(mode) == 4) {
        for (City c : cities) {
          System.out.println(c);
        }
      }
    }
  }

  private static String planeMenu() {
    String planeMenu = "";
    for (int index = 0; index < Shop.airplanes.length; index++) {
      planeMenu += index + ": " + Shop.airplanes[index].getName() + "\n";
      planeMenu += "\tCost: " + Shop.airplanes[index].getPrice() + "\n";
      planeMenu += "\tCapacity: " + Shop.airplanes[index].getCapacity() + "\n";
      planeMenu += "\tRange: " + Shop.airplanes[index].getRange() + "\n\n";
    }
    planeMenu += "Enter any other number to exit.\n\n";
    return planeMenu;
  }

  private static String cityMenu() {
    String cityMenu = "";
    for (int index = 0; index < Shop.cities.length; index++) {
      cityMenu += index + ": " + Shop.cities[index] + "\n";
      cityMenu += "\tCost: " + Shop.cities[index].getPop()*100 + "\n";
      cityMenu += "\tPopulation: " + Shop.cities[index].getPop() + "\n\n";
    }
    cityMenu += "Enter any other number to exit.\n\n";
    return cityMenu;
  }

  private static int fact( int n ) {
    int retNum = 1;
    for (int i = n; i > 0; i--) {
      retNum *= i;
    }
    return retNum;
  }

  private static ArrayList<FlightRoute> possibleFlights() {
    //optimizing the arraylist
    int permutation = fact(cities.size()) / fact(cities.size()-2);
    ArrayList<FlightRoute> routes = new ArrayList<FlightRoute>(permutation);
    for (Airplane plane : airplanes) {
      if (plane != null && plane.getStatus() != 1) {
        for (City city : cities) {
          if (plane.getCity() != city) {
            FlightRoute r = new FlightRoute( plane.getCity(), city, plane );
            routes.add(r);
            if (r.getDistance() > plane.getRange()) {
              routes.remove(routes.size()-1);
            }
          }
        }
      }
    }
    return routes;
  }

  private static void updateFlights() {
    for (int i = 0; i < flights.size(); i++) {
      FlightRoute r = flights.get(i);
      long currentTime = System.currentTimeMillis();
      if (r.getEndTime() < currentTime) {
        r.getAirplane().setStatus(0);
        r.getAirplane().setCity( r.getArrival() );
        flights.remove(i);
      }
    }
  }

  private static String prompt( String query ) {
    System.out.println(query);
    System.out.print(">> ");
    String input = "";
    try {
      input = in.readLine();
      int test = Integer.valueOf(input);
    }
    catch(IOException e) {
    }
    catch(NumberFormatException e) { 
      return "-1";
    }

    return input;
  }
}