public class City {
  
  private int _pop;
  private int _xcor;
  private int _ycor;
  private String _name;

  public City() {
    _name = "";
    _xcor = 0;
    _ycor = 0;
    _pop = 0;
  }

  public City( String n, int screenSize ) {
    _xcor = (int)(Math.random()*screenSize);
    _ycor = (int)(Math.random()*screenSize);
    _pop = (int)(Math.random()*100);
    _name = n;
  }

  public int getPop() {
    return _pop;
  }

  public int getXcor() {
    return _xcor;
  }

  public int getYcor() {
    return _ycor;
  }

  public String toString() {
    return _name;
  }
}
