import java.io.*;
import java.util.*;

public class Driver {

    public static final int SCREEN_SIZE = 600;

    private static InputStreamReader isr;
    private static BufferedReader in;

    private static Airplane[] airplanes;
    private static City[] cities;
    private static ArrayList<FlightRoute> flights;

    private static int money;

    public static void main( String[] args ) {

	isr = new InputStreamReader( System.in );
	in = new BufferedReader( isr );
	//100:1 Real:In Game
	money = 5000000;

	airplanes = new Airplane[5];
	// name, range, speed, capacity, price, fuelCapacity, currentCity
	airplanes[0] = Shop.airplanes[0];
	airplanes[1] = Shop.airplanes[1];

	cities = new City[4];
	for (int i = 0; i < 4; i++) {
	    cities[i] = new City(Shop.popCityName(), SCREEN_SIZE);
	}

	airplanes[0].setCity( cities[0] );
	airplanes[1].setCity( cities[1] );

	flights = new ArrayList<FlightRoute>();
    
        while (true) {
	    String mode = prompt( "\nMENU:\n" +
				  "0: Possible flight routes\n" +
				  "1: Your airplanes\n" +
				  "2: See current flights\n" +
				  "You have $" + money + ".");

	    if ( Integer.valueOf(mode) == 0 ) {
		ArrayList<FlightRoute> routes = possibleFlights();
		int routeNum = 0;
		if (routes.size() > 0) {
		    for (FlightRoute r : routes) {
			System.out.println("(" + routeNum + ") " + r);
			System.out.println("Coords of cities: " + 
					   "(" + r.getDeparture().getXcor() +
					   "," + r.getDeparture().getYcor() +
					   "),(" + r.getArrival().getXcor() +
					   "," + r.getArrival().getYcor() + ")");
			System.out.println();
			routeNum++;
		    }
		    String choice = prompt( "\nCHOICES:\n" +
					    "0: Start a flight\n" +
					    "1: Return to menu\n");
		    if (Integer.valueOf(choice) == 0){
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
		for (Airplane a : airplanes) {
		    System.out.println(a);
		}
	    } else if ( Integer.valueOf(mode) == 2) {
		updateFlights();
		for (FlightRoute r : flights) {
		    System.out.println(r);
		    System.out.println();
		}
	    }
	}
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
	int permutation = fact(cities.length) / fact(cities.length-2);
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
	}
	catch(IOException e){ }

	return input;
    }
}
