# frozen_string_literal: true

require 'constants'

class Piece
  include Constants
  attr_reader :type

  def initialize(type, color)
    @type = type
    @color = color
    @symbol = symbol_look_up(type, color)
    @current_square = nil
    @moved = false
    @move_squares = nil
    @attack_squares = nil
  end

  # @attack_style = attack_look_up(type)
  # @move_style = move_look_up(type, @moved)

  def symbol_look_up(type, color)
    symbol_hash = {
      white: {
        king: "\u{2654}", queen: "\u{2655}", rook: "\u{2656}", bishop: "\u{2657}", knight: "\u{2658}", pawn: "\u{2659}"
      },
      black: {
        king: "\u{265A}", queen: "\u{265B}", rook: "\u{265C}", bishop: "\u{265D}", knight: "\u{265E}", pawn: "\u{265F}"
      }
    }
    symbol_hash[color.to_sym][type.to_sym]
  end

  def update_movements_and_attacks(current_board)
    # attacks should be added to move_squares
    update_movements(current_board)
    update_attacks(current_board) if @type == 'pawn'
  end

  def move_look_up
    # need to adjust for pawn moving
    @move_hash = {
      king: [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]],
      knight: [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]],
      pawn: [[0, 1], [0, 2]]
    }

    @type == 'pawn' && @moved ? [[0, 1]] : @move_hash[type.to_sym]
  end

  def update_movements(current_board)
    # need to check if square is oppoent if can attack
    @move_squares = []
    new_coordinate = []

    current_column = @current_square[0]
    current_row = @current_square[1]

    if @type == 'queen' 
      find_all_diagonals(current_board, current_column, current_row)
      find_all_straights(current_board, current_column, current_row)
    elsif @type == 'bishop'
      find_all_diagonals(current_board, current_column, current_row)
    elsif @type == 'rook'
      find_all_straights(current_board, current_column, current_row)
    # elsif @type == 'pawn'

    else
      use_move_hash(current_board, current_column, current_row)
    end
  end

  def find_all_diagonals(current_board, current_column, current_row)
    diagonals = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

    diagonals.each do |direction|
      new_column = current_column
      new_row = current_row
      loop do
        new_column += direction[0]
        new_row += direction[1]
        new_coordinate = [new_column, new_row]

        new_square = current_board.find_square(new_coordinate)
        break if new_square == false

        unless new_square.occupant.nil?
          @move_squares << new_coordinate if new_square.occupant.instance_variable_get(:@color) != @color
          break
        end

        @move_squares << new_coordinate
      end
    end
  end

  def find_all_straights(current_board, current_column, current_row)
    straights = [[1, 0], [-1, 0], [0, 1], [0, -1]]

    straights.each do |direction|
      new_column = current_column
      new_row = current_row
      loop do
        new_column += direction[0]
        new_row += direction[1]
        new_coordinate = [new_column, new_row]

        new_square = current_board.find_square(new_coordinate)
        break if new_square == false

        unless new_square.occupant.nil?
          @move_squares << new_coordinate if new_square.occupant.instance_variable_get(:@color) != @color
          break
        end

        @move_squares << new_coordinate
      end
    end
  end

  def use_move_hash(current_board, current_column, current_row)
    movements_array = move_look_up
    movements_array.each do |move|
      new_column = current_column + move[0]
      new_row = current_row + move[1]
      new_coordinate = [new_column, new_row]

      new_square = current_board.find_square(new_coordinate)
      next if new_square == false

      if @type == 'pawn'
        break unless new_square.occupant.nil?
      else
        unless new_square.occupant.nil?
          @move_squares << new_coordinate if new_square.occupant.instance_variable_get(:@color) != @color
          break
        end
      end
      @move_squares << new_coordinate
    end
  end

  def update_attacks(current_board)
    pawn_attacks = [[1, 1], [-1, 1]]
    new_coordinate = []

    current_column = @current_square[0]
    current_row = @current_square[1]

    pawn_attacks.each do |move|
      new_column = current_column + move[0]
      new_row = current_row + move[1]
      new_coordinate = [new_column, new_row]

      new_square = current_board.find_square(new_coordinate)
      next if new_square == false

      unless new_square.occupant.nil?
        @move_squares << new_coordinate if new_square.occupant.instance_variable_get(:@color) != @color
        break
      end
    end
  end

end
