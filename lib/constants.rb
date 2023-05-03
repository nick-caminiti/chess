# frozen_string_literal: true

module Constants

  def symbol_look_up(type, color)
    symbol_hash = {
      white: {
        king: "\u{2654}", queen: "\u{2655}", rook: "\u{2656}",
        bishop: "\u{2657}", knight: "\u{2658}", pawn: "\u{2659}"
      },
      black: {
        king: "\u{265A}", queen: "\u{265B}", rook: "\u{265C}",
        bishop: "\u{265D}", knight: "\u{265E}", pawn: "\u{265F}"
      }
    }
    symbol_hash[color.to_sym][type.to_sym]
  end

  def move_look_up(type, moved)
    # need to adjust for pawn moving
    @move_hash = {
      king: [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]],
      queen: [[0, 7], [0, -7], [7, 0], [-7, 0], [7, 7], [7, -7], [-7, 7], [-7, -7]],
      rook: [[0, 7], [0, -7], [7, 0], [-7, 0]],
      bishop: [[7, 7], [7, -7], [-7, 7], [-7, -7]],
      knight: [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]],
      pawn: [[0, 1], [0, 2]]
    }

    move_hash_moved = { pawn: [[0, 1]] }

    @move_hash[type.to_sym]
  end

  def attack_look_up(type)
    @move_hash = {
      king: [[1, 1], [1, 0], [1, -1], [0, 1], [0, -1], [-1, 1], [-1, 0], [-1, -1]],
      queen: [[0, 7], [0, -7], [7, 0], [-7, 0], [7, 7], [7, -7], [-7, 7], [-7, -7]],
      rook: [[0, 7], [0, -7], [7, 0], [-7, 0]],
      bishop: [[7, 7], [7, -7], [-7, 7], [-7, -7]],
      knight: [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]],
      pawn: [[0, 1], [0, 2]]
    }

    attack_hash = {
      king: @move_hash[:king],
      queen: @move_hash[:queen],
      rook: @move_hash[:rook],
      bishop: @move_hash[:bishop],
      knight: @move_hash[:knight],
      pawn: [[1, 1], [-1, 1]]
    }

    attack_hash[type.to_sym]
  end
end