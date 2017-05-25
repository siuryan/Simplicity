class Map {

  int[][] _coords = new int[Shop.cities.length][3];
  ArrayList<FlightRoute> flights = Driver.flights;

  Map() {
    for (int i = 0; i < Shop.cities.length; i++) {
      _coords[i][0] = Shop.cities[i].getXcor();
      _coords[i][1] = Shop.cities[i].getYcor();
      _coords[i][2] = (int)(Math.random()*(Constants.WIDTH+Constants.HEIGHT)/2+(Constants.WIDTH+Constants.HEIGHT)/4);
    }
  }
  
  void update( ArrayList<City> c ) {
    background(color(1, 114, 153));  
    
    double dy;
    int dx;
    int x;
    int y;

    for (int i = 0; i < _coords.length; i++) {
      fill(color(144, 221, 99));
      noStroke();
      //ellipse(_coords[i][0], _coords[i][1], (float)Math.log(_coords[i][2])*60, (float)Math.log(_coords[i][2])*60);
      ellipse(_coords[i][0], _coords[i][1], _coords[i][2]/3, _coords[i][2]/3);
    }
    /* display shop cities
    for (int i = 0; i < Shop.cities.length; i++) {
      fill(0);
      ellipse(Shop.cities[i].getXcor(), Shop.cities[i].getYcor(), 10, 10);
      textSize(Constants.WIDTH/100);
      if (Shop.cities[i].getYcor() > Constants.HEIGHT - 20) {
        text(Shop.cities[i].getCityName(), Shop.cities[i].getXcor(), Shop.cities[i].getYcor()-20);
      } else {
        text(Shop.cities[i].getCityName(), Shop.cities[i].getXcor(), Shop.cities[i].getYcor()+10);
      }
    }
    */
    for (int i = 0; i < c.size(); i++) {
      fill(0);
      ellipse(c.get(i).getXcor(), c.get(i).getYcor(), 10, 10);
      textSize(Constants.WIDTH/100);
      if (c.get(i).getYcor() > Constants.HEIGHT - 20) {
        text(c.get(i).getCityName(), c.get(i).getXcor(), c.get(i).getYcor()-20);
      } else {
        text(c.get(i).getCityName(), c.get(i).getXcor(), c.get(i).getYcor()+10);
      }
    }
    /*
    for (int i = 0; i < flights.size(); i ++){
        dx = flights.get(i).getDeparture().getXcor() - flights.get(i).getArrival().getXcor();
        dx = dx / flights.get(i).getDistance();
        dy = flights.get(i).getDeparture().getYcor() - flights.get(i).getArrival().getYcor();
        dy = dy / flights.get(i).getDistance();
        x = flights.get(i).getDeparture().getXcor() + dx * flights.get(i).getTimeRem();
        y = flights.get(i).getDeparture().getYcor() + dx * flights.get(i).getTimeRem();
        
    }
    */
  }
}