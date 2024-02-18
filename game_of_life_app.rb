require_relative 'game_of_life'

class GameOfLifeApp

    def load_game
      display_game_menu
      loop do
        print "> "
        
        case get_user_input
        when '1'
          initial_state = [[0,1], [1,1], [2,1]]
          display_pattern(initial_state, 3, 3)
        when '2'
          initial_state = [[1, 1], [1, 2], [2, 1], [2, 2]]
          display_pattern(initial_state, 5, 5)
        when 'q'
          puts "Quitting the Game of Life Console App. Goodbye!"
          break
        else
          puts "Invalid option. Please choose again."
        end
      end
    end

    private

    def display_game_menu
      puts "Welcome to the Game of Life App"
      puts "Choose a pattern to start the simulation:"
      puts "1. Blinker"
      puts "2. Block"
      puts "Enter 'q' to quit"
    end
  
    def get_user_input
      $stdin.gets.chomp.downcase
    end
  
    def display_pattern(initial_state, rows, columns)
      game = GameOfLife.new(rows, columns, initial_state)
  
      puts "Current state:"
      game.display_board
  
      loop do
        puts "Press 'Enter' to generate the next state, or enter 'q' to quit."
        print "> "
        
        case get_user_input
        when ''
          game.get_board_next_state
          game.display_board
        when 'q'
          display_game_menu
          break
        else
          puts "Invalid input. Please try again."
        end
      end
    end
  end