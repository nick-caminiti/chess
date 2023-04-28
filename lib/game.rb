# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'piece'

class Game
  def initialize
    @board = nil
    @white = nil
    @black = nil
    @current_player = @white
  end

  def play_game
    set_up
    @board.print_board
    play_rounds
    wrap up
  end

  ########################################
  #### set_up
  ########################################

  def set_up
    print_intro
    user_input == 1 ? new_game : load_game
  end

  def new_game
    @white = Player.new('white')
    @black = Player.new('black')
    @board.create_board(@white, @black)
    @checkmate = nil
    @draw = false
  end

  def load_game; end

  ########################################
  #### play_rounds
  ########################################

  def play_rounds
    loop do
      draw_protocol
      break if @draw

      play_turn
      switch_current_player
      print_new_board_state

      checkmate_protocol
      break unless checkmate.nil?
    end
  end

  def draw_protocol
    @draw = true unless @board.check_for_legal_moves(@current_player)
    @draw = @current_player.prompt_for_draw if @board.check_for_draw
  end

  def play_turn
    puts "#{@current_player.color} you're up!"
    @board.make_move(get_move)
  end

  def switch_current_player; end

  def print_new_board_state
    @board.print_board
    puts 'check' if check_for_check(@current_player.king)
  end

  def checkmate_protocol
    @checkmate = @current_player.king if check_for_checkmate(@current_player.king)
  end

  def get_move
    # prompt for move
    # make sure move is legal
    # if move is illegal, say why
  end

  

  ########################################
  #### wrap_up
  ########################################

  def wrap_up
    declare_result
  end

  def declare_result
    declare_winner unless @checkmate.nil?
    declare_draw if @draw
  end

  def declare_winner
    winner = @checkmate == @white ? black : white
    puts "#{@checkmate.color} is in checkmate. #{winner} wins!"
  end

  def declare_draw; end





  def save_game; end
end

# game = Game.new
# game.play_rounds
