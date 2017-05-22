import java.io.*;
import java.util.*;

public class Driver {

    public static int SCREEN_SIZE = 600;

    private static InputStreamReader isr;
    private static BufferedReader in;

    public static Airplane[] airplanes;
    public static City[] cities;

    public static void main( String[] args ) {

	isr = new InputStreamReader( System.in );
	in = new BufferedReader( isr );

	airplanes = new Airplane[5];
	airplanes[0] = new Airplane( "Airbus", 100, 100, 10, 1000, 100, null);

	cities = new City[4];
	for (int i = 0; i < 4; i++) {
	    cities[i] = new City(i+"", SCREEN_SIZE);
	}

	airplanes[0].setCity( cities[0] );
    
        while (true) {
	    String mode = prompt( "\nMENU:\n" +
				  "0: Possible Flight Routes\n" +
				  "1: Your airplanes");

	    if ( Integer.valueOf(mode) == 0 ) {
		ArrayList<FlightRoute> routes = possibleFlights();
		for (FlightRoute r : routes) {
		    System.out.println(r);
		    System.out.println("(" + r.getDeparture().getXcor() +
				       "," + r.getDeparture().getYcor() +
				       "),(" + r.getArrival().getXcor() +
				       "," + r.getArrival().getYcor() + ")");
		    System.out.println();
		}
	    } else if ( Integer.valueOf(mode) == 1 ) {
		for (Airplane a : airplanes) {
		    System.out.println(a);
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
	    if (plane != null) {
		for (City city : cities) {
		    if (plane.getCity() != city) {
			routes.add(
			  new FlightRoute( plane.getCity(), city, plane )
			);
		    }
		}
	    }
	}
	return routes;
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
