class Map extends GUIElement {

  int[][] _coords = new int[20][3];

  Map( int w, int h, int x ) {
    for (int i = 0; i < _coords.length; i++) {
      _coords[i][0] = (int)(Math.random()*(w-x)+x);
      _coords[i][1] = (int)(Math.random()*h);
      _coords[i][2] = (int)(Math.random()*(w+h)/2+(w+h)/4);
    }
  }
  
  void update() {
    for (int i = 0; i < _coords.length; i++) {
      fill(color(144, 221, 99));
      noStroke();
      ellipse(_coords[i][0], _coords[i][1], _coords[i][2]/3, _coords[i][2]/3);
    }
    for (int i = 0; i < _coords.length; i++) {
      fill(0);
      ellipse(_coords[i][0], _coords[i][1], 10, 10);
    }
  }
}