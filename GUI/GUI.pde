String[] arr = {"0", "a", "2", "b", "4", "c", "6", "d", "8", "e", "10", "f", "12", "g", "14", "h", "16", "i", "18"};
Menu<String> test = new Menu<String>( 1000, 1000, 50, 25, color(121, 171, 252), "Hello world", arr );

void setup() {
  size(1000, 1000);
  //fullScreen();
  background(255);
}

void draw() {
  test.update();
}

void mousePressed() {
  if (test.overBack()) {
    test.prevPage();
  } else if (test.overNext()) {
    test.nextPage();
  } else if (test.overElement() != -1) {
    System.out.println(test.getElement(test.overElement()));
  }
}