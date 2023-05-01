# frozen_string_literal: true


class Square
  attr_accessor :occupant

  def initialize(coordinate)
    @coordinate = coordinate
    @column_high = nil
    @column_low = nil
    @row_high = nil
    @row_low = nil
    @diagonal_high_high = nil
    @diagonal_high_low = nil
    @diagonal_low_high = nil
    @diagonal_low_low = nil
    @occupant = ' '
  end

  @column_high = [1, 0]
  @column_low = [-1, 0]
  @row_high = [0, 1]
  @row_low = [0, -1]
  @diagonal_high_high = [1, 1]
  @diagonal_high_low = [1, -1]
  @diagonal_low_high = [-1, 1]
  @diagonal_low_low = [-1, -1]

  @coordinate = 'b3'
  @column_high = 'c3'
  @column_low = 'a3'
  @row_high = 'b4'
  @row_low = 'b2'
  @diagonal_high_high = 'c4'
  @diagonal_high_low = 'c2'
  @diagonal_low_high = 'a4'
  @diagonal_low_low = 'a2'
end