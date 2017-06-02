int i = 3;
float x = 0;
float y = 0;

boolean animEnded;
boolean gameStarted;

void setup() {
  size(600, 600);
  background(0);

  animEnded = false;
  gameStarted = false;
}

void draw() {
  if (i < 201) {
    background(0);
    PImage img = loadImage("../Driver/img/Airplane.png");
    PImage img2 = loadImage("../Driver/img/Airplane_rev.png");
    int num = 150;
    if (x < width && y < height) {
      x = width/num * i;
      y = height/num * i;
      image(img, x, y, 50, 50);
      image(img2, width-x-50, y, 50, 50);
    }
    i++;
    textAlign(CENTER, CENTER);
    textSize(i/3);
    text( "Airline Simulator", 0, height/2 - 50, width, height/6 );
  } else if (!animEnded) {
    textSize(20);
    text( "Click anywhere to play", 0, height/3 * 2, width, height/12 );
    animEnded = true;
  } else if (gameStarted) {
    background(255);
  }
}

void mousePressed() {
  if (animEnded) {
    gameStarted = true;
  }
}