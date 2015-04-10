require 'pry'
class ChessValidator
	def initialize
		
	end

	def check(board, movelist)
		output = ""
		movelist.each do |move|
			if is_legal(board, move)
				output << "#{move}: LEGAL\n"
			else
				output << "#{move}: ILEGAL\n"
			end
		end
		puts output
		IO.write('simple_results.txt', output)
	end

	def is_legal(board, move)
		piece = get_piece(board, move)
		origin = get_origin(move)
		destiny = get_destiny(move)
		piece.check_moves(origin, destiny) unless piece.class == String
		
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
			# e5: Pawn.new(:w),
			# a2: Rook.new(:b),
			# a3: Knigth.new(:w)
		}
	end

	def get_board(board_creator)
		@cells = board_creator
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
	def initialize(color)
		@color = color
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

class King < Piece
	def check_moves(origin, destiny)
		horizontal_relation(origin, destiny) <= 1 && vertical_relation(origin, destiny) <= 1
	end
end

class Pawn < Piece
	def initialize(color)
		super
		@first_move = true
	end

	def check_moves(origin, destiny)
		vertical = destiny[1].ord - origin[1].ord
		horizontal = destiny[0].ord - origin[0].ord
		if vertical > 0 && horizontal == 0
			unless @first_move
				vertical == 1
			else
				@first_move = false
				vertical == 1 || vertical == 2
			end
		else
			false
		end
	end
end

class Knigth < Piece
	def check_moves(origin, destiny)
		horizontal = horizontal_relation(origin, destiny)
		vertical = vertical_relation(origin, destiny)
		if horizontal != vertical
			(horizontal == 2 || horizontal == 1) && (vertical == 1 || vertical == 2)
		else
			false
		end
	end
end


class BoardCreator
	attr_reader :cells
	def initialize
		@cells = {}
	end
	def set_board_from_txt(txt)
		txt_board = IO.read(txt)
		create_columns(create_lines(txt_board))
		@cells
	end

	def create_lines(txt_board)
		lines = {}
		line_number = 8
		txt_board.split(/\n/).each do |line|
			lines[line_number] = line
			line_number -= 1
		end
		lines
	end

	def create_columns(lines)
		column_number = "a".ord
		lines.each do |key, line|
			split_line(key, line, column_number)
			column_number = "a".ord	
		end
	end

	def split_line(key, line, column_number)
		line.split(" ").each do |cell|
			create_key(column_number, key, cell)
			column_number += 1
		end	
	end

	def create_key(column_number, initial_key, cell)
		key = column_number.chr + initial_key.to_s	
		@cells[key.to_sym] = PieceCreator.new.create_piece(cell)
	end
end

class PieceCreator

	def create_piece(input)		
		choose_piece(input, set_color(input))
	end
	def set_color(input)
		if input[0] == "w"
			:white
		elsif input[0] == "b"
			:black
		end
	end
	

	def choose_piece(cell, color)
		case cell[1]
		when "P"
			Pawn.new(color)
		when "R"
			Rook.new(color)
		when "N"
			Knigth.new(color)
		when "B"
			Bishop.new(color)
		when "Q"
			Queen.new(color)
		when "K"
			King.new(color)
		else
			cell
		end
	end

end
class MovesList
#create a list of moves from IO file
	def initialize
		@moves
	end
end

king = PieceCreator.new.create_piece("wK")

movelist = [[:e5, :b2], [:e5, :g7], [:e5, :b8], [:e5, :h2], [:e5, :e1], [:e5, :f1], [:e5, :e6], [:e5, :f6], [:e5, :d5]]
knight_movelist = [[:e5, :d7], [:e5, :f7], [:e5, :g6], [:e5, :g4], [:e5, :f3], [:e5, :d3], [:e5, :c4], [:e5, :c6], [:e5, :b5]]
board_creator = BoardCreator.new.set_board_from_txt('simple_board.txt')
board = Board.new
board.get_board(board_creator)



validator = ChessValidator.new
validator.check(board, movelist)

binding.pry
puts "The pry line"
