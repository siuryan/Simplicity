import java.io.*;
import java.util.*;

public class Driver {

    public static int HEIGHT = 600;
    public static int WIDTH = 600;
    
    private City[] cities;
    private Airplane[] airplanes;

    private InputStreamReader isr;
    private BufferedReader in;

    public Driver() {
	_data = new ArrayPriorityQueue<Ticket>();
	isr = new InputStreamReader( System.in );
	in = new BufferedReader( isr );
	_running = true;
    }

    public void static main( String[] args ) {

	Driver d = new Driver();

	d.airplanes = new Airplane[5];
	d.airplanes[0] = new Airplane( "Airbus", 100, 100, 10, 1000, 100, null);
	System.out.println(d.airplanes[0].getSpeed()); 
	System.out.println(d.airplanes[0]);

	d.cities = new City[15];
	for (int i = 0; i < 15; i++) {
	    d.cities[i] = new City(i+"", (int)(Math.random()*WIDTH), (int)(Math.random()*HEIGHT), (int)(Math.random()*100));
	}

	d.airplanes[0].setCity( cities[0] );
	System.out.println(d.airplanes[0].getCity());
    
        while (true) {
	    System.out.println("MENU:\n");
	    System.out.print(">> ");
	    String mode = "";
	    try {
		mode = in.readLine();
	    }
	    catch(IOException e){ }

	    if ( mode.equals('0') ) {

	    }
	}
    }
}
