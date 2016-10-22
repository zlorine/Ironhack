require 'imdb'
# require 'pry'

class FilmRatings

		def initialize(file)
			
			@film = IO.read(file)
			@filmTitles = []
			@film.each_line do |line|
			@filmTitles << line.chomp
			end

		
		end

		def search

				@titles = []
				@ratings = []

				@filmTitles.each do |title|


								@filmOnImdb = Imdb::Search.new(title).movies

								@titles << @filmOnImdb[0].title
								@ratings << @filmOnImdb[0].rating.round()


								end

				@FilmsWithRatings = Hash[@titles.zip(@ratings)]	
				
		end	

		def show

			search
			@FilmsWithRatings.each do |title, rating|
				puts "#{title}: #{rating}"
			end


		end

		def chart
			search

			currentRating = 10
			
				while currentRating > 0
					@ratings.each do |rate|

						
								if rate >= currentRating
									print "|#"
								else
									print "| "
								end

								
						end
						puts " "
						currentRating = currentRating - 1
					
				end

					i = 1

					while i <= @titles.size
						print "|"+i.to_s
						i = i + 1
							# binding.pry
					end
					
					 puts " \n \n "

						@titles.each.with_index(1) do |title,index|
							puts "#{index}) #{title}"
							end 

							puts " \n \n "
		end


end



table = FilmRatings.new("movies.txt")


table.chart

# table.show
