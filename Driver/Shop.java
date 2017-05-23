public final class Shop {

    public static Airplane[] airplanes = {
	new Airplane( "Airbus A380", 300, 100, 50, 4200000, 100, null),
	new Airplane( "Boeing 787", 300, 100, 25, 3000000, 100, null)
    };

    public static String[] cityNames = {
	"New York", "Los Angeles", "San Francisco", "Houston", "Boston",
	"Washington DC"
    };
    
    public static String popCityName() {
	int index = (int)(Math.random()*cityNames.length);
	String cityName = cityNames[index];
	removeCity( index );
	return cityName;
    }

    private static void removeCity( int index ) {
	String[] copy = new String[cityNames.length-1];
        for (int i = 0; i < index; i++) {
	    copy[i] = cityNames[i];
	}
	for (int i = index+1; i < cityNames.length; i++) {
	    copy[i-1] = cityNames[i];
	}
	cityNames = copy;
    }
    
}
