# frozen_string_literal: true

class Square
  attr_accessor :occupant

  def initialize(coordinate)
    @coordinate = coordinate
    @occupant = nil
  end
end