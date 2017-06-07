import java.awt.*;
import java.net.*;

final color THEME_COLOR = color(121, 171, 252);

// Instance vars
private static ArrayList<Airplane> airplanes;
private static ArrayList<City> cities;
private static ArrayList<FlightRoute> flights;

private static int money;

private static int mode;

private static boolean mouseClicked;

private static int currentPage;

//for flight route creator
Airplane[] arrPlanes;
Airplane routePlane;
HashMap <City, ArrayList<City>> paths;
City[] destinations;

// Animation constants
int animCounter = 3;
float animX = 0;
float animY = 0;
int animColor = 0;

boolean animEnded;
boolean gameStarted;

// Main screen instantiation
String[] mainMenuContents = {"Start a Flight", "Airplanes", "Cities", "Flight Routes", "Shop", "Help", "Exit"};
Menu<String> mainMenu = new Menu<String>( "Airline Simulator", Constants.MENU_MAP_DIVIDE, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, mainMenuContents, false );
Map map = new Map( );

void setup() {
  size(1500, 800); // should match Constants.WIDTH, Constants.HEIGHT
  background(color(1, 114, 153));  

  money = 5000000;

  airplanes = new ArrayList<Airplane>();

  // if we want to give a free plane to start with
  airplanes.add(Shop.buy(Shop.airplanes[0]));

  // start with 2 random cities from the shop
  cities = new ArrayList<City>();
  for (int i = 0; i < 2; i++) {
    cities.add(Shop.popCity());
  }

  // if free plane given
  airplanes.get(0).setCity( cities.get(0) );

  flights = new ArrayList<FlightRoute>();

  mode = 99;

  mouseClicked = false;

  currentPage = 0;

  animEnded = false;
  gameStarted = false;
}

void draw() {

  /*
  Each "mode" represents a different in-game screen:
   -1: exit
   0: main
   1: possible flight routes (airplanes)
   2: view airplanes
   3: view current flight routes
   4: shop
   5: help
   6: shop -- airplanes
   7: shop -- cities
   8: refuel airplanes
   9: possible flight routes (choose flights)
   10: view cities
   99: startup animation
   */

  switch (mode) {

    // exit
  case -1:
    exit();
    break;

    // startup animation
  case 99:
    if (animCounter < 201) {
      background(0);
      PImage img = loadImage("../Driver/img/Airplane.png");
      PImage img2 = loadImage("../Driver/img/Airplane_rev.png");
      int num = 150;
      if (animX < width && animY < height) {
        animX = width/num * animCounter;
        animY = height/num * animCounter;
        image(img, animX, animY, 50, 50);
        image(img2, width-animX-50, animY, 50, 50);
      }
      animCounter++;
      textAlign(CENTER, CENTER);
      textSize(animCounter/3);
      text( "Airline Simulator", 0, height/2 - 50, width, height/6 );
    } else if (!animEnded) {
      textSize(20);
      text( "Click anywhere to play", 0, height/3 * 2, width, height/12 );
      animEnded = true;
    } else if (gameStarted) {
      if (animColor < 254) {
        background(animColor+=2);
      } else {
        mode = 0;
      }
    }
    break;

    // main
  case 0:
    map.update( cities, flights );
    mainMenu.update();
    if (mouseClicked) {
      if (mainMenu.overElement(7) != -1) {
        String input = mainMenu.getElement(mainMenu.overElement(7));
        currentPage = 0;
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
        case "Cities":
          mode = 10;
          break;
        case "Flight Routes":
          mode = 3;
          break;
        case "Shop":
          mode = 4;
          break;
        case "Help":
          mode = 5;
          break;
        }
      }
    }

    // draw money text
    textSize(Constants.HEIGHT/25);
    fill(255);
    text("$" + money, Constants.MENU_MAP_DIVIDE/2, Constants.HEIGHT_NO_FOOTER);
    break;

    // possible flight routes
  case 1:
    //only show planes not currently flying
    ArrayList<Airplane> arrPlaneAL = new ArrayList<Airplane>();
    for (Airplane possiblePlane : airplanes) {
      if (possiblePlane.getStatus() == 0) {
        arrPlaneAL.add(possiblePlane);
      }
    }
    arrPlanes = arrPlaneAL.toArray(new Airplane[arrPlaneAL.size()]);


    Menu<Airplane> possiblePlaneMenu = new Menu<Airplane>( "Start a Flight: Choose an airplane/departure city", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, arrPlanes, true, currentPage );
    possiblePlaneMenu.update();

    // handle interactions
    if (mouseClicked) {
      if (mainMenu.overElement(arrPlanes.length) != -1) {
        int input = mainMenu.overElement(arrPlanes.length);

        System.out.println(input);

        routePlane = arrPlaneAL.get(input);
        paths = Pathfind.getPaths(routePlane.getRange(), routePlane.getCity(), cities);
        destinations = new City[paths.size()];
        int count = 0;
        for (City dest : paths.keySet()) {
          System.out.println(dest);
          destinations[count] = dest;
          count++;
        }
        System.out.println(paths.entrySet());
        for (City dest : destinations) {
          System.out.println(dest);
        }
        mode = 9;
      }

      if (possiblePlaneMenu.overBack()) {
        possiblePlaneMenu.prevPage();
        currentPage = possiblePlaneMenu.getPage();
      } else if (possiblePlaneMenu.overNext()) {
        possiblePlaneMenu.nextPage();
        currentPage = possiblePlaneMenu.getPage();
      } else if (possiblePlaneMenu.overExit()) {
        mode = 0;
      }
    }

    break;


    // view airplanes
  case 2:
    Airplane[] planes = airplanes.toArray(new Airplane[airplanes.size()]);
    Menu<Airplane> airplaneMenu = new Menu<Airplane>( "Airplanes", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, planes, true, currentPage );
    airplaneMenu.update();
    if (mouseClicked) {
      if (airplaneMenu.overBack()) {
        airplaneMenu.prevPage();
        currentPage = airplaneMenu.getPage();
      } else if (airplaneMenu.overNext()) {
        airplaneMenu.nextPage();
        currentPage = airplaneMenu.getPage();
      } else if (airplaneMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // current flights
  case 3:
    // create menu
    FlightRoute[] routes = flights.toArray(new FlightRoute[flights.size()]);
    Menu<FlightRoute> flightMenu = new Menu<FlightRoute>( "Flight Routes", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 6, THEME_COLOR, routes, true, currentPage );
    flightMenu.update();

    // handle interactions
    if (mouseClicked) {
      if (flightMenu.overBack()) {
        flightMenu.prevPage();
        currentPage = flightMenu.getPage();
      } else if (flightMenu.overNext()) {
        flightMenu.nextPage();
        currentPage = flightMenu.getPage();
      } else if (flightMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // shop
  case 4:
    // create menu
    String[] mainShopMenuContents = {"Airplanes", "Cities", "Refuel"};
    Menu<String> mainShopMenu = new Menu<String>( "Shop", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, mainShopMenuContents, true, currentPage );
    mainShopMenu.update();

    // handle interactions
    if (mouseClicked) {
      if (mainShopMenu.overElement(mainShopMenuContents.length) != -1) {
        int input = mainMenu.overElement(mainShopMenuContents.length);
        System.out.println(input);
        if (input == 0) {
          mode = 6; //airplane
        } else if (input == 1) {
          mode = 7; //cities
        } else if (input == 2) {
          mode = 8; //refuel
        }
      }

      if (mainShopMenu.overBack()) {
        mainShopMenu.prevPage();
        currentPage = mainShopMenu.getPage();
      } else if (mainShopMenu.overNext()) {
        mainShopMenu.nextPage();
        currentPage = mainShopMenu.getPage();
      } else if (mainShopMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // help
  case 5:
    try {
      // open a new window in browser to help page
      Desktop.getDesktop().browse(new URL("https://github.com/siuryan/Simplicity/blob/master/Help.md").toURI());
      mode = 0;
    } 
    catch (Exception e) {
    }
    break;

    // Shop -- Airplanes
  case 6:
    // create menu
    Airplane[] newAirplanes = Shop.airplanes;
    Menu<Airplane> airplaneShop = new Menu<Airplane>("Airplanes", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, newAirplanes, true, currentPage );
    airplaneShop.update();

    // handle interactions
    if (mouseClicked) {
      if (airplaneShop.overElement(newAirplanes.length) != -1) {
        int input = airplaneShop.overElement(newAirplanes.length);
        if (newAirplanes[input].getPrice() <= money) {
          Airplane a = Shop.buy(newAirplanes[input]);
          airplanes.add(a);
          a.setCity(cities.get(0));
          money -= newAirplanes[input].getPrice();
          mode = 0;
        } else {
          mode = 11;
        }
      } else if (airplaneShop.overBack()) {
        airplaneShop.prevPage();
        currentPage = airplaneShop.getPage();
      } else if (airplaneShop.overNext()) {
        airplaneShop.nextPage();
        currentPage = airplaneShop.getPage();
      } else if (airplaneShop.overExit()) {
        mode = 4;
        currentPage = 0;
      }
    }
    break;

    // Shop -- Cities
  case 7:
    // create menu
    City[] newCities = Shop.cities;
    for (City eachCity : newCities) {
      eachCity.setStatus(1);
    }
    Menu<City> citiesShop = new Menu<City>("Cities", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, newCities, true, currentPage );
    citiesShop.update();

    // handle interactions
    if (mouseClicked) {
      if (citiesShop.overElement(newCities.length) != -1) {
        int input = citiesShop.overElement(newCities.length);
        if (newCities[input].getPrice() <= money) {
          cities.add(newCities[input]);
          Shop.removeCity(input);
          newCities[input].setStatus(0);
          money -= newCities[input].getPrice();
          mode = 0;
        } else {
          mode = 11;
        }
      } else if (citiesShop.overBack()) {
        citiesShop.prevPage();
        currentPage = citiesShop.getPage();
      } else if (citiesShop.overNext()) {
        citiesShop.nextPage();
        currentPage = citiesShop.getPage();
      } else if (citiesShop.overExit()) {
        mode = 4;
        currentPage = 0;
      }
    }
    break;

    // refill fuel
  case 8:
    // create menu
    Airplane[] refills = Shop.toBeFilled(airplanes);
    Menu<Airplane> refillShop = new Menu<Airplane>("Refuel", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, refills, true, currentPage );
    refillShop.update();
    for (int i = 0; i < refills.length; i ++) {
      refills[i].setState(1);
    }

    // handle interactions
    if (mouseClicked) {
      if (refillShop.overElement(refills.length) != -1) {
        int input = refillShop.overElement(refills.length);
        money -= refills[input].getCost();
        refills[input].refuel();
        refills[input].setState(1);
        mode = 0;
      } else if (refillShop.overBack()) {
        refillShop.prevPage();
        currentPage = refillShop.getPage();
      } else if (refillShop.overNext()) {
        refillShop.nextPage();
        currentPage = refillShop.getPage();
      } else if (refillShop.overExit()) {
        mode = 4;
        currentPage = 0;
      }
    }

    break;

    // display possible flight routes
  case 9:
    // create menu
    if (paths.size() > 0) {

      for (int i = 0; i < destinations.length; i ++) {
        destinations[i].setStatus(2);
        destinations[i].setProfit(profit(routePlane.getCity(), destinations[i], routePlane));
      }
      Menu<City> possibleDestMenu = new Menu<City>( "Start a Flight: Choose a destination (if not immediately accessible, will direct to a stopover city)", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, destinations, true, currentPage );
      possibleDestMenu.update();
      if (mouseClicked) {
        if (mainMenu.overElement(destinations.length) != -1) {
          int inputDest = mainMenu.overElement(destinations.length);
          System.out.println(inputDest);
          System.out.println(destinations);
          City destCity = destinations[inputDest];
          for (int i = 0; i < destinations.length; i ++) {
            destinations[i].setStatus(0);
          }
          if (possibleDestMenu.overBack()) {
            possibleDestMenu.prevPage();
            currentPage = possibleDestMenu.getPage();
          } else if (possibleDestMenu.overNext()) {
            possibleDestMenu.nextPage();
            currentPage = possibleDestMenu.getPage();
          } else if (possibleDestMenu.overExit()) {
            mode = 0;
          }

          FlightRoute route = new FlightRoute(routePlane.getCity(), paths.get(destCity).get(1), routePlane);
          flights.add(route);
          System.out.println(route);
          routePlane.setStatus(1);
          routePlane.setTank(route.getDistance());
          money += route.getProfit();
          mode = 0;
          System.out.println("Statuses set");
          System.out.println(airplanes);
        }

        if (possibleDestMenu.overBack()) {
          possibleDestMenu.prevPage();
          currentPage = possibleDestMenu.getPage();
        } else if (possibleDestMenu.overNext()) {
          possibleDestMenu.nextPage();
          currentPage = possibleDestMenu.getPage();
        } else if (possibleDestMenu.overExit()) {
          mode = 0;
        }
      }
    } else {
      String[] noDests = {"No destinations"};
      Menu<String> possibleDestMenu = new Menu<String>( "Start a Flight: Choose a destination (if not immediately accessible, will direct to a stopover city)", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 4, THEME_COLOR, noDests, true, currentPage );
      possibleDestMenu.update();
      if (mouseClicked) {
        mode = 0;
      }
    }

    break;

    // view cities
  case 10:
    City[] citiesArr = cities.toArray(new City[cities.size()]);
    for (City eachCity : citiesArr) {
      eachCity.setStatus(0);
    }
    Menu<City> cityMenu = new Menu<City>( "Cities", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 2, THEME_COLOR, citiesArr, true, currentPage );
    cityMenu.update();
    if (mouseClicked) {
      if (cityMenu.overBack()) {
        cityMenu.prevPage();
        currentPage = cityMenu.getPage();
      } else if (cityMenu.overNext()) {
        cityMenu.nextPage();
        currentPage = cityMenu.getPage();
      } else if (cityMenu.overExit()) {
        mode = 0;
      }
    }
    break;

    // not enough money to buy a shop item
  case 11:
    String[] noDests = {"Not enough money"};
    Menu<String> possibleShopMenu = new Menu<String>( "Shop", Constants.WIDTH, Constants.HEIGHT_NO_FOOTER, 50, 25, 4, THEME_COLOR, noDests, true, currentPage );
    possibleShopMenu.update();
    if (mouseClicked) {
      mode = 0;
    }
    break;
  }

  // handle loop tasks
  updateFlights();
  mouseClicked = false;
}

void mousePressed() {
  mouseClicked = true;
  if (animEnded) {
    gameStarted = true;
  }
}

/**
 Returns n!.
 */
static int fact( int n ) {
  int retNum = 1;
  for (int i = n; i > 0; i--) {
    retNum *= i;
  }
  return retNum;
}

/**
 Finds all the possible FlightRoutes, given the current state of the game.
 return ArrayList<FlightRoute> - contains the possible FlightRoutes
 */
static ArrayList<FlightRoute> possibleFlights() {

  //optimizing the arraylist
  int permutation = fact(cities.size()) / fact(cities.size()-2);
  ArrayList<FlightRoute> routes = new ArrayList<FlightRoute>(permutation);

  // goes through every plane, looking for possible flight routes from the plane's current city to another city
  for (Airplane plane : airplanes) {
    if (plane != null && plane.getStatus() != 1) {
      for (City city : cities) {
        if (plane.getCity() != city) {
          FlightRoute r = new FlightRoute( plane.getCity(), city, plane );
          routes.add(r);
          if (r.getDistance() > plane.getRange() || plane.check(r.getDistance()) < 0) {
            routes.remove(routes.size()-1);
          }
        }
      }
    }
  }
  return routes;
}

/**
 Manages the current flights, removes them if they finish.
 */
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

/**
 Calculates the profit from flying between these cities with a certain Airplane.
 returns int - profit
 */
static int profit(City depart, City arrival, Airplane plane) {
  double x1 = depart.getXcor();
  double y1 = depart.getYcor();
  double x2 = arrival.getXcor();
  double y2 = arrival.getYcor();
  double distance = Math.sqrt( (y2-y1)*(y2-y1) + (x2-x1)*(x2-x1) );
  int passengers = (int)Math.sqrt((depart.getPop()+arrival.getPop())/2);
  if (passengers > plane.getCapacity()) {
    passengers = plane.getCapacity();
  }
  return (int) (passengers * distance);
}