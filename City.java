public class City{
    private int population;
    private int xcor;
    private int ycor;
    private String name;
    
    public City(int x, int y, int pop, String n){
	xcor = x;
	ycor = y;
	population = pop;
	name = n;
    }

    public int getPop(){
	return population;
    }

    public int getX(){
	return xcor;
    }

    public int getY(){
	return ycor;
    }

    public String getName(){
	return name;
    }

}
