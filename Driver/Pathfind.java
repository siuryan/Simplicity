public class Pathfind {

    //double{known?, distance, prevNode}
    HashMap<City,double[]> distances;
    City start, current;

    public Pathfind(int range, City startCity) {
	start = startCity;
	current = startCity;
	distances = new HashMap(Driver.getCities().size());
	for (City city: Driver.getCities()) {
	    if (city.equals(startCity)) {
		distances.put(city, {1,0,-1});
	    }
	    else {
		distances.put(city,{0,9999,-1});
	    }
	}
    }

    public HashMap<City, City[]> getPaths() {
	for (City city: Driver.getCities()) {
	    if (!(city.equals(start)) {
		    
