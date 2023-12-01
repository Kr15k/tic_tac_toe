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

      visualize_board
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
      # for lang metode, veldig spesifikk bruk og veldig repetetiv
      if place <= 3
        if @rows[0][place - 1][0] != 'x' && @rows[0][place - 1][0] != 'o'
          @rows[0][place - 1][0] = marker
        else
          puts 'Please enter a valid field'
          @error = true
        end
      elsif place <= 6
        if @rows[1][place - 4][0] != 'x' && @rows[1][place - 4][0] != 'o'
          @rows[1][place - 4][0] = marker
        else
          puts 'Please enter a valid field'
          @error = true
        end
      elsif place <= 9
        if @rows[2][place - 7][0] != 'x' && @rows[2][place - 7][0] != 'o'
          @rows[2][place - 7][0] = marker
        else
          puts 'Please enter a valid field'
          @error = true
        end
      end
    end

    def is_error(value)
      if (1..9) === value.to_i && value.to_i.to_s == value
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
        input1 = gets.chomp
        input = input1.to_i
        is_error(input1)
        if @error == false
          if marker === 'x' && @error == false
            place_marker('x', input)
            visualize_board
            check_for_win('xxx', 'Player1')
            marker = 'o' unless @error == true
          elsif marker === 'o' && @error == false
            place_marker('o', input)
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

# legge til score
