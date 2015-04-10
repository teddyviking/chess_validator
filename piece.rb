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