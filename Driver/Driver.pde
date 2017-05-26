import java.awt.*;
import java.net.*;

final color THEME_COLOR = color(121, 171, 252);

private static ArrayList<Airplane> airplanes;
private static ArrayList<City> cities;
private static ArrayList<FlightRoute> flights;

private static int money;

private static int mode;

private static boolean mouseClicked;

String[] mainMenuContents = {"Start a Flight", "Airplanes", "Flight Routes", "Shop", "Help", "Exit"};
Menu<String> mainMenu = new Menu<String>( "Airline Simulator", Constants.MENU_MAP_DIVIDE, Constants.HEIGHT*13/14, 50, 25, 2, THEME_COLOR, mainMenuContents, false );
Map map = new Map( );

void setup() {
  size(1500, 1000); // should match WIDTH, HEIGHT
  //fullScreen();
  background(color(1, 114, 153));  

  money = 5000000;

  airplanes = new ArrayList<Airplane>();

  //if we want to give a free plane to start with
  airplanes.add(Shop.airplanes[0]);
  //airplanes.add(Shop.airplanes[1]);

  cities = new ArrayList<City>();
  for (int i = 0; i < 2; i++) {
    cities.add(Shop.popCity());
  }

  //if free plane given
  airplanes.get(0).setCity( cities.get(0) );
  //airplanes.get(1).setCity( cities.get(1) );

  flights = new ArrayList<FlightRoute>();

  mode = 0;

  mouseClicked = false;
}

void draw() {
  switch (mode) {

    // exit
  case -1:
    exit();
    break;

    // main
  case 0:
    map.update( cities, flights );
    mainMenu.update();
    if (mouseClicked) {
      if (mainMenu.overElement() != -1) {
        String input = mainMenu.getElement(mainMenu.overElement());
        switch (input) {
        case "Exit":
          mode = -1;
          break;
        case "Start a Flight":
          mode = 1;
          break;
        case "Airplanes":
          mode = 2;
          break;
        case "Flight Routes":
          mode = 3;
          break;
        case "Help":
          mode = 5;
          break;
        }
      }
    }
    textSize(Constants.HEIGHT/25);
    fill(255);
    text("$" + money, Constants.MENU_MAP_DIVIDE/2, Constants.HEIGHT*13/14);
    break;

    // possible flight routes
  case 1:
    ArrayList<FlightRoute> possibleRoutes = possibleFlights();
    FlightRoute[] arrRoutes = possibleRoutes.toArray(new FlightRoute[possibleRoutes.size()]);
    Menu<FlightRoute> possibleFlightMenu = new Menu<FlightRoute>( "Start a Flight", Constants.WIDTH, Constants.HEIGHT, 50, 25, 4, THEME_COLOR, arrRoutes, true );
    possibleFlightMenu.update();
    if (mouseClicked) {
      if (mainMenu.overElement() != -1) {
        int input = mainMenu.overElement();
        System.out.println(input);
        FlightRoute route = possibleRoutes.get(input);
        flights.add(route);
        route.getAirplane().setStatus(1);
        money += route.getProfit();
        mode = 0;
      }
      if (possibleFlightMenu.overBack()) {
        possibleFlightMenu.prevPage();
      } else if (possibleFlightMenu.overNext()) {
        possibleFlightMenu.nextPage();
      } else if (possibleFlightMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // view airplanes
  case 2:
    Airplane[] planes = airplanes.toArray(new Airplane[airplanes.size()]);
    Menu<Airplane> airplaneMenu = new Menu<Airplane>( "Airplanes", Constants.WIDTH, Constants.HEIGHT, 50, 25, 2, THEME_COLOR, planes, true );
    airplaneMenu.update();
    if (mouseClicked) {
      if (airplaneMenu.overBack()) {
        airplaneMenu.prevPage();
      } else if (airplaneMenu.overNext()) {
        airplaneMenu.nextPage();
      } else if (airplaneMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // current flights
  case 3:
    FlightRoute[] routes = flights.toArray(new FlightRoute[flights.size()]);
    Menu<FlightRoute> flightMenu = new Menu<FlightRoute>( "Flight Routes", Constants.WIDTH, Constants.HEIGHT, 50, 25, 6, THEME_COLOR, routes, true );
    flightMenu.update();
    if (mouseClicked) {
      if (flightMenu.overBack()) {
        flightMenu.prevPage();
      } else if (flightMenu.overNext()) {
        flightMenu.nextPage();
      } else if (flightMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // shop
  case 4:
    break;

    // help
  case 5:
    try {
      Desktop.getDesktop().browse(new URL("https://github.com/siuryan/Simplicity").toURI());
      mode = 0;
    } 
    catch (Exception e) {
    }
    break;
  }
  updateFlights();
  mouseClicked = false;
}

void mouseClicked() {
  mouseClicked = true;
}

static int fact( int n ) {
  int retNum = 1;
  for (int i = n; i > 0; i--) {
    retNum *= i;
  }
  return retNum;
}

static ArrayList<FlightRoute> possibleFlights() {
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

static void updateFlights() {
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