require 'rspec'
require_relative '../game_of_life_app'

RSpec.describe GameOfLifeApp do
  describe "#game of life app should:" do

    it "return correct output when user selects an invalid option" do

      expected_output = <<~OUTPUT
      Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Invalid option. Please choose again.
      > Quitting the Game of Life Console App. Goodbye!
      OUTPUT

      app = GameOfLifeApp.new

      # Stubbing the get_user_input method
      allow(app).to receive(:get_user_input).and_return('t', 'q')

      # Use StringIO to capture the output
      output = StringIO.new
      $stdout = output

      app.load_game

      # Reset $stdout
      $stdout = STDOUT

      # Get the captured output as a string
      output_string = output.string
      
      expect(output_string).to eq(expected_output)
    end

    it "return correct output when user selects blinker option" do

      expected_output = <<~OUTPUT
      Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Current state:
      o x o 
      o x o 
      o x o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Quitting the Game of Life Console App. Goodbye!
      OUTPUT


      app = GameOfLifeApp.new

      # Stubbing the get_user_input method
      allow(app).to receive(:get_user_input).and_return('1', 'q')

      # Use StringIO to capture the output
      output = StringIO.new
      $stdout = output

      app.load_game

      # Reset $stdout
      $stdout = STDOUT

      # Get the captured output as a string
      output_string = output.string
      
      expect(output_string).to eq(expected_output)
    end

    it "return correct output when user selects blinker option and then selects an Invalid option" do

      expected_output = <<~OUTPUT
      Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Current state:
      o x o 
      o x o 
      o x o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > Invalid input. Please try again.
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Quitting the Game of Life Console App. Goodbye!
      OUTPUT



      app = GameOfLifeApp.new

      # Stubbing the get_user_input method
      allow(app).to receive(:get_user_input).and_return('1', 't', 'q')

      # Use StringIO to capture the output
      output = StringIO.new
      $stdout = output

      app.load_game

      # Reset $stdout
      $stdout = STDOUT

      # Get the captured output as a string
      output_string = output.string
      
      expect(output_string).to eq(expected_output)
    end

    it "return correct output when user selects blinker option and selects next generation" do

      expected_output = <<~OUTPUT
      Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Current state:
      o x o 
      o x o 
      o x o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > o o o 
      x x x 
      o o o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Quitting the Game of Life Console App. Goodbye!
      OUTPUT

      app = GameOfLifeApp.new

      # Stubbing the get_user_input method
      allow(app).to receive(:get_user_input).and_return('1', '', 'q', 'q')

      # Use StringIO to capture the output
      output = StringIO.new
      $stdout = output

      app.load_game

      # Reset $stdout
      $stdout = STDOUT

      # Get the captured output as a string
      output_string = output.string

      expect(output_string).to eq(expected_output)
    end

    it "return correct output when user selects block option" do
      expected_output = <<~OUTPUT
      Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Current state:
      o o o o o 
      o x x o o 
      o x x o o 
      o o o o o 
      o o o o o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Quitting the Game of Life Console App. Goodbye!
      OUTPUT



      app = GameOfLifeApp.new

      # Stubbing the get_user_input method
      allow(app).to receive(:get_user_input).and_return('2', 'q')

      # Use StringIO to capture the output
      output = StringIO.new
      $stdout = output

      app.load_game

      # Reset $stdout
      $stdout = STDOUT

      # Get the captured output as a string
      output_string = output.string
      
      expect(output_string).to eq(expected_output)
    end

    it "return correct output when user selects block option and selects next generation" do
      expected_output = <<~OUTPUT
      Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Current state:
      o o o o o 
      o x x o o 
      o x x o o 
      o o o o o 
      o o o o o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > o o o o o 
      o x x o o 
      o x x o o 
      o o o o o 
      o o o o o 
      
      Press 'Enter' to generate the next state, or enter 'q' to quit.
      > Welcome to the Game of Life App
      Choose a pattern to start the simulation:
      1. Blinker
      2. Block
      Enter 'q' to quit
      > Quitting the Game of Life Console App. Goodbye!
      OUTPUT

      app = GameOfLifeApp.new

      # Stubbing the get_user_input method
      allow(app).to receive(:get_user_input).and_return('2', '', 'q', 'q')

      # Use StringIO to capture the output
      output = StringIO.new
      $stdout = output

      app.load_game

      # Reset $stdout
      $stdout = STDOUT

      # Get the captured output as a string
      output_string = output.string
      
      expect(output_string).to eq(expected_output)
    end

  end
end
