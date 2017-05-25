private static ArrayList<Airplane> airplanes;
private static ArrayList<City> cities;
private static ArrayList<FlightRoute> flights;

private static int money;

String[] arr = {"Back", "a", "2", "b", "4", "c", "6", "d", "8", "e", "10", "f", "12", "g", "14", "h", "16", "i", "18"};
Menu<String> mainMenu = new Menu<String>( "Menu", Constants.MENU_MAP_DIVIDE, Constants.HEIGHT, 50, 25, color(121, 171, 252), arr );
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
}

void draw() {
  map.update( cities );
  mainMenu.update();
}

void mousePressed() {
  if (mainMenu.overBack()) {
    mainMenu.prevPage();
  } else if (mainMenu.overNext()) {
    mainMenu.nextPage();
  } else if (mainMenu.overElement() != -1) {
    System.out.println(mainMenu.getElement(mainMenu.overElement()));
  }
}