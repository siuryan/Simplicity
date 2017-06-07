import java.util.*;

public class Pathfind {

  private static double getDistance(City begin, City end) {
    return Math.sqrt(Math.pow(begin.getXcor() - end.getXcor(), 2) + Math.pow(begin.getYcor() - end.getYcor(), 2));
  }


  public static HashMap<City, ArrayList<City>> getPaths(int range, City start, ArrayList<City> cities) {

    //initialize values
    //double{visited, distance};
    HashMap<City, double[]> distances = new HashMap(cities.size());
    double[] placeholder;
    for (City city : cities) {
      if (city.equals(start)) {
        distances.put(city, new double[] {1, 0});
      } else {
        distances.put(city, new double[] {0, Integer.MAX_VALUE});
      }
    }

    City current = start;

    HashMap<City, ArrayList<City>> retHash = new HashMap<City, ArrayList<City>>();
    ArrayList<City> tempPath;
    double dist;
    double[] tempInsert;
    double minDist = 0;

    while (minDist < Integer.MAX_VALUE) {

      //set current node to visited
      tempInsert = distances.get(current);
      tempInsert[0] = 1;
      distances.put(current, tempInsert);

      //find tentative distances
      for (City city : cities) {
        if (!(city.equals(current)) && distances.get(city)[0] == 0) {
          dist = getDistance(city, current);
          //replace distance with shorter one if applicable
          if (dist + distances.get(current)[1] < distances.get(city)[1] && dist <= range) {
            tempInsert = distances.get(city);
            tempInsert[1] = dist;
            distances.put(city, tempInsert);
            //replace path
            if (!(current.equals(start))) {
              tempPath = new ArrayList<City>(retHash.get(current));
            } else {
              tempPath = new ArrayList<City>();
            }
            tempPath.add(current);
            //tempPath.add(city);
            retHash.put(city, tempPath);
          }
        }
      }


      //find next destination
      minDist = Integer.MAX_VALUE;
      for (City city : cities) {
        if (distances.get(city)[0] == 0) {
          if (distances.get(city)[1] < minDist) {
            current = city;
            minDist = distances.get(city)[1];
          }
        }
      }
    }

    for (City city: retHash.keySet()) {
      tempPath = retHash.get(city);
      tempPath.add(city);
      retHash.put(city,tempPath);
    }


    return retHash;
  }
}