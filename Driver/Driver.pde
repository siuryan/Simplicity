City[] cities;
Airplane[] airplanes;

void setup() {
  size(600, 600);
  background(255);

  airplanes = new Airplane[5];
  airplanes[0] = new Airplane( "Airbus", 100, 100, 10, 1000, 100, null);
  System.out.println(airplanes[0].getSpeed()); 
  System.out.println(airplanes[0]);

  cities = new City[15];
  for (int i = 0; i < 15; i++) {
    cities[i] = new City(i+"", (int)(Math.random()*width), (int)(Math.random()*height), (int)(Math.random()*100));
  }

  airplanes[0].setCity( cities[0] );
  System.out.println(airplanes[0].getCity());
}

void draw() {
  for (City c : cities) {
    fill(128, 128, 128);
    ellipse(c.getXcor(), c.getYcor(), c.getPop(), c.getPop());
    fill(0, 0, 0);
    text(c.toString(), c.getXcor(), c.getYcor());
  }
  for (Airplane a : airplanes) {
    if (a != null) {
      fill(0);
      rect(a.getCity().getXcor(), a.getCity().getYcor(), 15, 15);
    }
  }
}