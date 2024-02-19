# Conway's Game of Life

This is a simple implementation of the Conway's Game of Life written with Ruby. The application is a console app that allows the player to either select a blinker, block or a glider pattern, and keeps displaying the next state as long as the player presses enter. For now, the initial states of the game is hard coded but the core logic is built to display any pattern.


## Introduction

Conway's Game of Life is a cellular automaton that simulates the evolution of a grid of cells over time based on a set of simple rules. Each cell can be either alive or dead, and its state in the next generation is determined by the states of its neighboring cells.

## Code Structure

1. The entry point of the application is ```main.rb```. It is what loads the game and it does this by calling the ```GameOfLifeApp``` class in the ```game_of_life_app.rb``` file.
2. The ```game_of_life_app.rb``` file contains the I/O logic of the application. This is where the console interaction with the user happens.
3. The ```game_of_life.rb```file contains logic that displays the board and calculates the next state of the board.
4. The tests folder contains both the unit test and integration test


## Installation

To run the application, follow these steps:

1. Install Ruby. If You do not have Ruby installed, then you will need to install Ruby
2. Go to the root directory and run ```bundle install```
3. launch the application by running ```ruby main.rb```

## Testing

1. To run the unit test run ```ruby tests/test_game_of_life_unit.rb```
2. To run the integration test run ```rspec tests/test_game_of_life_integration.rb```

