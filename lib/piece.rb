# frozen_string_literal: true

class Piece
  def initialize(type)
    # move hashes into Module
    @type = type
    @current_square = nil
    @symbol_hash = { king: 'K', queen: 'Q', rook: 'R', bishop: 'B', knight: 'N', pawn: 'P' }
    @symbol = @symbol_hash[type.to_sym]
    @move_hash = {
      king: [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]],
      queen: [[0, 7], [0, -7], [7, 0], [-7, 0], [7, 7], [7, -7], [-7, 7], [-7, -7]],
      rook: [[0, 7], [0, -7], [7, 0], [-7, 0]],
      bishop: [[7, 7], [7, -7], [-7, 7], [-7, -7]],
      knight: [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]],
      pawn_first: [[0, 1], [0, 2]],
      pawn_rest: [[0, 1]]
    }
    @attack_hash = {
      king: @move_hash['king'],
      queen: @move_hash['queen'],
      rook: @move_hash['rook'],
      bishop: @move_hash['bishop'],
      knight: @move_hash['knight'],
      pawn: [[1, 1], [-1, 1]]
    }
    @attack_style = @attack_hash[type.to_sym]
    @move_style = @move_hash[type.to_sym]
    @attack_squares = nil
    @move_squares = nil
    @can_jump = type == 'knight'
    @moved = false
  end

end