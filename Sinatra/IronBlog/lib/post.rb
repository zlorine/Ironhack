class Post 

	attr_reader :title, :text, :url

	def initialize(title,text)

		@title = title
		@text = text
		@date_created = Time.now
		@date_modified = Time.now

	end

	def update(title,text)

		@title = title
		@text = text
		@date_modified = Time.now
		
		
	end	

	def date_created
		@date_created
	end

	def date_modified
		@date_modified
	end

	def title
		@title
	end

	def text
		@text
	end

	def url
		@url = @title.downcase.tr(' ', '_') 
	end

end