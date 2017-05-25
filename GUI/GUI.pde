public static int WIDTH = 1500;
public static int HEIGHT = 1000;
public static int MENU_MAP_DIVIDE = 500;

String[] arr = {"Back", "a", "2", "b", "4", "c", "6", "d", "8", "e", "10", "f", "12", "g", "14", "h", "16", "i", "18"};
Menu<String> testMenu = new Menu<String>( "Menu", MENU_MAP_DIVIDE, HEIGHT, 50, 25, color(121, 171, 252), arr );
Map map = new Map( WIDTH, HEIGHT, MENU_MAP_DIVIDE );

void setup() {
  size(1500, 1000); // should match WIDTH, HEIGHT
  //fullScreen();
  background(color(1, 114, 153));  
}

void draw() {
  map.update();
  testMenu.update();
}

void mousePressed() {
  if (testMenu.overBack()) {
    testMenu.prevPage();
  } else if (testMenu.overNext()) {
    testMenu.nextPage();
  } else if (testMenu.overElement() != -1) {
    System.out.println(testMenu.getElement(testMenu.overElement()));
  }
}