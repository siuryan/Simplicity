private static ArrayList<Airplane> airplanes;
private static ArrayList<City> cities;
private static ArrayList<FlightRoute> flights;

private static int money;

private static int mode;

private static boolean mouseClicked;

String[] mainMenuContents = {"Start a Flight", "Airplanes", "Flight Routes", "Shop", "Help", "Exit"};
Menu<String> mainMenu = new Menu<String>( "Airline Simulator", Constants.MENU_MAP_DIVIDE, Constants.HEIGHT, 50, 25, color(121, 171, 252), mainMenuContents, false );
Map map = new Map( );

void setup() {
  size(1500, 1000); // should match WIDTH, HEIGHT
  //fullScreen();
  background(color(1, 114, 153));  

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

  mode = 0;

  mouseClicked = false;
}

void draw() {
  switch (mode) {
  // main
  case 0:
    map.update( cities );
    mainMenu.update();
    if (mouseClicked) {
      if (mainMenu.overElement() != -1) {
        String input = mainMenu.getElement(mainMenu.overElement());
        switch (input) {
        case "Airplanes":
          mode = 2;
          break;
        }
      }
    }
    break;
  // view airplanes
  case 2:
    //String[] airplaneMenuContents = {"Back", "Next"};
    Airplane[] planes = airplanes.toArray(new Airplane[airplanes.size()]);
    Menu<Airplane> airplaneMenu = new Menu<Airplane>( "Airplanes", Constants.WIDTH, Constants.HEIGHT, 50, 25, color(121, 171, 252), planes, true );
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
  // exit
  case 5:
    //System.exit(0);
    break;
  }
  mouseClicked = false;
}

void mouseClicked() {
  mouseClicked = true;
}