require "sinatra"
require "sinatra/reloader"
require 'pry'
require "./lib/blog.rb"
require "./lib/post.rb"
enable :sessions


blog = Blog.new

blog.add_post(Post.new("Welcome to the absolute nothing","I am nothing.<br/> I'll never be anything.<br/>I couldn't want to be something.<br/>Apart from that, I have in me all the dreams in the world.<br/><br/><b>Fernando Pessoa</b>"))
blog.add_post(Post.new("Still nothing really","We can regard our life as a uselessly disturbing episode in the blissful repose of nothingness.<br/><br><b>Arthur Schopenhauer</b>"))

get "/ironblog" do 
    @list_of_posts = blog.latest_posts
    # binding.pry
	erb(:ironblog)

end

get "/ironblog/post/:url" do
	# binding.pry
	@post = blog.list_of_posts.find {|post| post.url == params[:url].to_s}
	# binding.pry
	erb(:post)	

end