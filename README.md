# Simplicity
Ryan Siu, Eric Zhang, Tiffany Moi<br>
Airline simulator game for APCS2 final project

## Description
Welcome to our airline game! In this game, you are the owner of an airline company and you get to choose your own flight routes between different cities! You start out with some money and an airplane and your goal is to make more money by starting new flight routes. With the money you earn, you can buy better airplanes with greater efficiency and range and you can also unlock cities with higher populations. The profit you gain from each flight is determined by the size of the city and the capacity of your airplanes, so your goal is to buy the best airplanes and unlock the biggest cities. 

## How it Works
Our game works by creating instances of Cities, Airplanes, and FlightRoutes that the user possesses, and other instances of Cities and Airplanes are created in a Shop class as well, where they can be added to the user's collection the game progresses. 
### Algorithms
The FlightRoutes available to the user are generated based all of the possible connections from each Airplane's current City to each City in the Airplane's range. A suggested FlightRoute feature would find the circuit of paths starting from the Airplane's current City that would generate the most money.


## Instructions
There are two versions of this game: a Processing GUI version with the latest features, and a terminal, text-based version that was developed for testing. The terminal version may not have all the features contained in the GUI version, and may contain bugs.

To run the GUI version:
1. Open ```Driver.pde``` in the ```Driver``` directory, contained in the root of this repo.
2. Press run. Enjoy!

To run the terminal version:
1. Move or copy ```Driver.java```, contained in the ```terminal``` directory, to the ```Driver``` directory.
2. Compile ```Driver.java```.
3. ```java Driver``` to run.

## How to Play
See [here](https://github.com/siuryan/Simplicity/blob/master/Help.md) for more details.
