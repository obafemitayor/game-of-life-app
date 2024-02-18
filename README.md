# Conway's Game of Life

This is a simple implementation of the Conway's Game of Life written with Ruby. The application is a console app that displays two pattern options: blinker pattern, and block pattern, and keeps displaying the nxt state as long as the user presses enter.


## Introduction

Conway's Game of Life is a cellular automaton that simulates the evolution of a grid of cells over time based on a set of simple rules. Each cell can be either alive or dead, and its state in the next generation is determined by the states of its neighboring cells.


## Installation

To run the application, follow these steps:

1. Install Ruby. If You do not have Ruby installed, then you will need to install Ruby
2. Go to the root directory and run ```bundle install```
3. launch the application by running ```ruby main.rb```

## Testing

1. To run the unit test run ```ruby tests/test_game_of_life_unit.rb```
2. To run the integration test run ```rspec tests/test_game_of_life_integration.rb```

