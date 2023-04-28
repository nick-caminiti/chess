# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = nil
    @player_one = nil
    @player_two = nil
  end 

  def play_game
    set_up
    @board.print_board
    play_rounds
    wrap up
  end

  def set_up
    print_intro
    user_input == 1 ? new_game : load_game
  end

  def new_game
    set_board

  end

  def play_rounds; end

  def wrap_up; end

end