# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'piece'

class Game
  def initialize
    @board = nil
    @white = nil
    @black = nil
    @current_player = nil
    @check = false
    @checkmate = nil
    @draw = false
  end

  def play_game
    set_up
    @board.print_board(@current_player)
    play_rounds
    wrap_up
  end

  ########################################
  #### set_up
  ########################################

  def set_up
    new_game
    # print_intro
    # game_option_input == 1 ? new_game : load_game
  end

  def game_option_input
    puts 'Enter 1 to start a new game or enter 2 to load a game.'
    user_input
  end

  def new_game
    @white = Player.new('white')
    @black = Player.new('black')
    @board = Board.new(@white, @black)
    @board.build_board
    @current_player = @white
  end

  def load_game; end

  def user_input; end

  ########################################
  #### play_rounds
  ########################################

  def play_rounds
    loop do
      # draw_protocol
      break if @draw

      play_turn
      switch_current_player
      @check = check_for_check(@current_player.color, @current_player.king.instance_variable_get(:current_square))
      print_new_board_state

      checkmate_protocol if @check
      break unless checkmate.nil?
    end
  end

  def draw_protocol
    unless @board.check_for_legal_moves(@current_player)
      @draw = true
      @draw_reason = 'No legal moves'
    end

    return unless @board.draw_conditions_met

    @board.update_draw_reason
    @draw = true if @current_player.prompt_for_draw(@current_player, @board.draw_reason) == true
    @board.draw_reason = nil unless @draw == true
  end

  def play_turn
    loop do
      input = @current_player.get_turn_input
      if input == 'S'
        save_game
        exit
      elsif @board.check_for_legal_move(@current_player.color, input)
        input_coordinates = convert_input_to_coordinates(input)
        @board.make_move(input_coordinates[0], input_coordinates[1])
        break
      end
    end
    @board.update_piece_movements_and_attacks
  end

  def convert_input_to_coordinates(input)
    current_coordinate = @board.convert_alphanum_to_num(input[0, 2])
    new_coordinate = @board.convert_alphanum_to_num(input[3, 4])
    [current_coordinate, new_coordinate]
  end

  def switch_current_player
    # needs a test
    @current_player = @current_player == @white ? @black : @white
  end

  def print_new_board_state
    @board.print_board(@current_player)
    puts 'check' if @check
  end

  def checkmate_protocol
    @checkmate = @current_player.king if @board.check_for_checkmate(@current_player.king)
  end

  def save_game; end

  ########################################
  #### wrap_up
  ########################################

  def wrap_up
    declare_result
    prompt_for_new_game
  end

  def declare_result
    declare_winner unless @checkmate.nil?
    declare_draw if @draw
  end

  def prompt_for_new_game; end

  def declare_winner
    winner = @checkmate == @white ? @black : @white
    puts "#{@checkmate.color} is in checkmate. #{winner.color} wins!"
  end

  def declare_draw
    puts "We'll call it a draw! #{@board.draw_reason}"
  end
end

# game = Game.new
# game.play_rounds
