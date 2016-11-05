class Blog

	def initialize

	 @list_of_posts = []	

	end


	def add_post(post)

     @list_of_posts << post

	end

	# def display_posts

	#  @list_of_posts.each do |post|

	#  	post 

	#  end
	# end

	def list_of_posts
		@list_of_posts
	end

	def latest_posts
		@list_of_posts.reverse
	end


end
