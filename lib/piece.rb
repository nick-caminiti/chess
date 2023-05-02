# frozen_string_literal: true

class Piece
  attr_reader :type

  def initialize(type, color)
    # move hashes into Module
    @type = type
    @color = color
    @current_square = nil
    @symbol_hash = { king: 'K', queen: 'Q', rook: 'R', bishop: 'B', knight: 'N', pawn: 'P' }
    @symbol = @symbol_hash[type.to_sym]
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