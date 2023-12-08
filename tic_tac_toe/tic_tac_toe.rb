module TicTacToe
  class Game
    def initialize
      @rows = [
        [[1], [2], [3]],
        [[4], [5], [6]],
        [[7], [8], [9]]
      ]
    end

    def visualize_board
      @rows.each_index do |i|
        puts @rows[i].join(' | ')
        puts '---------'
      end
    end

    def check_if_win_x(marker, player)
      @rows.each_index do |i|
        next unless @rows[i].join == marker

        puts "#{player} won!"
        @win = true
      end
    end

    def check_if_win_y(marker, player)
      big_board = @rows.flatten
      @rows.each_index do |i|
        line = big_board[i], big_board[i + 3], big_board[i + 6]
        next unless line.join == marker

        puts "#{player} won!"
        @win = true
      end
    end

    def check_if_win_diagonal(marker, player)
      big_board = @rows.flatten
      line1 = big_board[0], big_board[0 + 4], big_board[0 + 8]
      line2 = big_board[2], big_board[2 + 2], big_board[2 + 4]
      return unless line1.join == marker || line2.join == marker

      puts "#{player} won!"
      @win = true
    end

    def check_if_draw
      big_board = @rows.flatten
      @draw = 0
      big_board.each_index do |i|
        @draw += 1 if big_board[i] == 'x' || big_board[i] == 'o'
      end
      return unless @draw >= 9 && @win == false

      puts "It's a draw!"
      @win = true
    end

    def check_for_win(marker, player)
      check_if_win_diagonal(marker, player)
      check_if_win_x(marker, player)
      check_if_win_y(marker, player)
      check_if_draw
    end

    def place_marker(marker, place)
      not_valid_place = true
      @rows.each_index do |i|
        @rows.each_index do |a|
          if @rows[i][a].include? place
            @rows[i][a][0] = marker
            not_valid_place = false
          end
        end
      end
      return unless not_valid_place == true

      puts 'Please enter a valid field'
    end

    def is_input_allowed(value)
      if (1..9).include?(value.to_i) && value.to_i.to_s == value
        @error = false
      else
        @error = true
        puts 'invalid'
        visualize_board
      end
    end

    def play
      # for lang metode, veldig spesifikk bruk
      marker = 'x'
      @win = false
      @error = false
      visualize_board
      until @win == true
        input = gets
        is_input_allowed(input.chomp)
        if @error == false
          if marker === 'x' && @error == false
            place_marker('x', input.to_i)
            visualize_board
            check_for_win('xxx', 'Player1')
            marker = 'o' unless @error == true
          elsif marker === 'o' && @error == false
            place_marker('o', input.to_i)
            visualize_board
            check_for_win('ooo', 'Player2')
            marker = 'x' unless @error == true
          end
        end
      end
    end
  end
end

new_board = TicTacToe::Game.new.play

# legge til score og loop spillet
