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