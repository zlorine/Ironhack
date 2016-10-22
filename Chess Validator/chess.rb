require  = "pry"

board = []
for n in 8.downto(1)
line = ("a"..."i").map{ |letter| letter + n.to_s}
board << line
end

board.each do |line|
	line.each do |square|
		print square.to_s
	end
	puts ''
end
