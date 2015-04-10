require 'pry'
class ChessValidator
	def initialize
		
	end

	def check(board, movelist)
		movelist.each do |move|
			if is_legal(board, move)
				puts "LEGAL"
			else
				puts "ILEGAL"
			end
		end
	end

	def is_legal(board, move)
		piece = get_piece(board, move)
		origin = get_origin(move)
		destiny = get_destiny(move)
		piece.check_moves(origin, destiny)
	end

	def get_piece(board, move)
		board.cells[move[0]]
	end

	def get_origin(move)
		move[0]
	end

	def get_destiny(move)
		move[1]
	end
end

class Board
#create board from IO file	
	attr_reader :cells
	def initialize
		@cells = {
			e5: Bishop.new,
			a2: Rook.new,
			a3: "knight"
		}
	end

end

module Checker
	def check_columns(origin, destiny)
		destiny[0] == origin[0] || destiny[1] == origin[1]
	end

	def check_diagonals(origin, destiny)
		horizontal_relation(origin, destiny) == vertical_relation(origin, destiny)	
	end	

	def horizontal_relation(origin, destiny)
		horizontal_relation = destiny[0].ord - origin[0].ord
		horizontal_relation < 0 ? -horizontal_relation : horizontal_relation
	end

	def vertical_relation(origin, destiny)
		vertical_relation = destiny[1].ord - origin[1].ord
		vertical_relation < 0 ? -vertical_relation : vertical_relation
	end	
end

class Piece
	include Checker
	attr_reader :moves
	def initialize
		@color
	end
end

class Rook < Piece
	def check_moves(origin, destiny)
		check_columns(origin, destiny) 
	end
end

class Bishop < Piece
	def check_moves(origin, destiny)
		horizontal_relation(origin, destiny) == vertical_relation(origin, destiny)
	end

end

class Queen < Piece
	def check_moves(origin, destiny)
		check_columns(origin, destiny) || check_diagonals(origin, destiny)
	end
end



class MovesList
#create a list of moves from IO file
	def initialize
		@moves
	end
end



movelist = [[:e5, :b2], [:e5, :g7], [:e5, :b8], [:e5, :h2], [:e5, :e1], [:e5, :f1]]
board = Board.new


validator = ChessValidator.new
validator.check(board, movelist)
