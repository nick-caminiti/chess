# frozen_string_literal: true

class Piece
  attr_reader :type

  def initialize(type, color)
    # move hashes into Module
    @type = type
    @color = color
    @current_square = nil
    @symbol_hash = {
      white: {
        king: "\u{2654}", queen: "\u{2655}", rook: "\u{2656}",
        bishop: "\u{2657}", knight: "\u{2658}", pawn: "\u{2659}"
      },
      black: {
        king: "\u{265A}", queen: "\u{265B}", rook: "\u{265C}",
        bishop: "\u{265D}", knight: "\u{265E}", pawn: "\u{265F}"
      }
    }
    @symbol = @symbol_hash[color.to_sym][type.to_sym]
    @move_hash_first_move = {
      king: [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]],
      queen: [[0, 7], [0, -7], [7, 0], [-7, 0], [7, 7], [7, -7], [-7, 7], [-7, -7]],
      rook: [[0, 7], [0, -7], [7, 0], [-7, 0]],
      bishop: [[7, 7], [7, -7], [-7, 7], [-7, -7]],
      knight: [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]],
      pawn: [[0, 1], [0, 2]]
    }
    @move_hash_moved = {
      king: [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]],
      queen: [[0, 7], [0, -7], [7, 0], [-7, 0], [7, 7], [7, -7], [-7, 7], [-7, -7]],
      rook: [[0, 7], [0, -7], [7, 0], [-7, 0]],
      bishop: [[7, 7], [7, -7], [-7, 7], [-7, -7]],
      knight: [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]],
      pawn: [[0, 1]]
    }
    @attack_hash = {
      king: @move_hash_first_move[:king],
      queen: @move_hash_first_move[:queen],
      rook: @move_hash_first_move[:rook],
      bishop: @move_hash_first_move[:bishop],
      knight: @move_hash_first_move[:knight],
      pawn: [[1, 1], [-1, 1]]
    }
    @attack_style = @attack_hash[type.to_sym]
    @move_style = @attack_hash[type.to_sym]
    @attack_squares = nil
    @move_squares = nil
    @can_jump = type == 'knight'
    @moved = false
  end

end