
require 'pry'
$LOAD_PATH << '.'
require_relative './checker.rb'
require_relative './chess_validator.rb'
require_relative './board.rb'
require_relative './piece.rb'
require_relative './moves_list.rb'




king = PieceCreator.new.create_piece("wK")

movelist = [[:e5, :b2], [:e5, :g7], [:e5, :b8], [:e5, :h2], [:e5, :e1], [:e5, :f1], [:e5, :e6], [:e5, :f6], [:e5, :d5]]
knight_movelist = [[:e5, :d7], [:e5, :f7], [:e5, :g6], [:e5, :g4], [:e5, :f3], [:e5, :d3], [:e5, :c4], [:e5, :c6], [:e5, :b5]]
board_creator = BoardCreator.new.set_board_from_txt('extra/simple_board.txt')
board = Board.new
board.get_board(board_creator)
validator = ChessValidator.new
validator.check(board, MovesList.new.create_list_from_txt('extra/simple_moves.txt'), 'extra/RESULTS.txt')

binding.pry
puts "The pry line"