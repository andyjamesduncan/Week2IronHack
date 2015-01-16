require 'pp'
require 'awesome_print'

class Validator

	def different_squares(x_start, y_start, x_end, y_end)

		if ((x_start == x_end) && (y_start == y_end))
			return 0
		end
		return 1
	end

	def start_posn_occupied(chess_grid, x_start, y_start)

		if chess_grid.grid[x_start.to_i][y_start.to_i].to_s == "Empty"

			return 0
		end

		return 1
	end

	def empty_board_move_ok(chess_grid, x_start, y_start, x_end, y_end)

		start_posn = chess_grid.grid[x_start.to_i][y_start.to_i]

		unless start_posn.valid_move_empty_board(x_end.to_i, y_end.to_i) == 1

			return 0
		end

		return 1
	end

	def if_occupied_opposite_color(chess_grid, x_start, y_start, x_end, y_end)

		start_posn = chess_grid.grid[x_start.to_i][y_start.to_i]
		end_posn = chess_grid.grid[x_end.to_i][y_end.to_i]

		unless end_posn.to_s == "Empty"

			if start_posn.color == end_posn.color
				return 0
			end
		end

		return 1
	end

	def intervening_piece_checker(chess_grid, x_start, y_start, x_end, y_end)

		start_posn = chess_grid.grid[x_start.to_i][y_start.to_i]

		unless start_posn.can_jump == 1

			intervening_squares_array = get_intervening_squares(chess_grid, x_start, y_start, x_end, y_end)
		end

		return 1
	end

	def get_intervening_squares(chess_grid, x_start, y_start, x_end, y_end)

		return_hash = {}

		high_x = x_end
		low_x = x_start
		high_y = y_end
		low_y = y_start

		if x_start > x_end
			high_x = x_start
			low_x = x_end
		end

		if y_start > y_end
			high_y = y_start
			low_y = y_end
		end

		if ((high_y == low_y) || (high_x == low_x))
			# Rook style move

			
		else
			# Bishop style move

		#if 

		#if x_start == x_end 

	end
end

class ChessGrid

	attr_accessor :grid

	def initialize

		@grid = [[],[],[],[],[],[],[],[]]

		x_posn = 0;
		y_posn = 0;

		max_x_posn = 7;
		max_y_posn = 7;

		chess_grid_counter = 0

		while x_posn <= max_x_posn

			y_posn = 0

			while y_posn <= max_y_posn

				grid[x_posn][y_posn] = "Empty"

				y_posn += 1
				chess_grid_counter += 1
			end

			x_posn += 1
		end
	end
end

class ConfigPieces

	attr_accessor :all_pieces

	def initialize

		@all_pieces = 	{	'WhiteRook1' => ['Rook', 'white', 0, 0],
							'WhiteRook2' => ['Rook', 'black', 0, 5]
						}
	end

	def set_board(chess_grid)

		all_pieces.keys.each do |piece|

			piece_array = all_pieces[piece]

			piece_type = piece_array[0]
			piece_color = piece_array[1]
			piece_start_x = piece_array[2]
			piece_start_y = piece_array[3]

			chess_grid.grid[piece_start_x][piece_start_y] =
				Kernel.const_get(piece_type).new(piece_color, piece_start_x, piece_start_y)
		end
	end

end

class Rook

	attr_accessor :color, :start_posn_x, :start_posn_y

	def initialize(color, start_posn_x, start_posn_y)

		@color = color
		@start_posn_x = start_posn_x.to_i
		@start_posn_y = start_posn_y.to_i

	end

	def valid_move_empty_board(end_x, end_y)

		return_flag = 0

		if @start_posn_x != end_x.to_i
			if @start_posn_y == end_y.to_i
				return_flag = 1
			else
				return_flag = 0
			end
		else
			if @start_posn_y != end_y.to_i
				return_flag = 1
			else
				return_flag = 0
			end
		end

		return return_flag
	end

	def can_jump
		return 0
	end
end

chess_grid = ChessGrid.new
config_pieces = ConfigPieces.new
validator = Validator.new

config_pieces.set_board(chess_grid)

#ap config_pieces
ap chess_grid

keep_going = 1

while keep_going == 1

	puts "\n[q] will quit\n\n"

	print "Please input a move in the numeric format X:Y,X:Y, e.g. 0:0,0:5 > "

	input = gets.chomp

	if input == "q"
		keep_going = 0
	else
		input = "0:0,0:5"

		first_split = input.split(",")
		start_coords = first_split[0].split(":")
		end_coords = first_split[1].split(":")

		x_start = start_coords[0]
		y_start = start_coords[1]

		x_end = end_coords[0]
		y_end = end_coords[1]

		puts "\nX: Start => " + x_start.to_s
		puts "Y: Start => " + y_start.to_s
		puts "X: End   => " + x_end.to_s
		puts "X: End   => " + y_end.to_s

		if ((validator.start_posn_occupied(chess_grid, x_start, y_start) == 1)						&&
			(validator.empty_board_move_ok(chess_grid, x_start, y_start, x_end, y_end) == 1)		&&
			(validator.if_occupied_opposite_color(chess_grid, x_start, y_start, x_end, y_end) == 1)	&&
			(validator.intervening_piece_checker(chess_grid, x_start, y_start, x_end, y_end) == 1)	&&
			(validator.different_squares(x_start, y_start, x_end, y_end) == 1)
		)

			puts "\nLegal Move! :-) \n"

		else
			puts "\nIllegal Move! :-( \n"
		end
	end
end

puts "\nBye bye Baby! :-)\n\n"

