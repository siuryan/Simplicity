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

  public City( String n, int x, int y, int pop ) {
    _xcor = x;
    _ycor = y;
    _pop = pop;
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