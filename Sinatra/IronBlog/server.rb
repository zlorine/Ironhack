require "sinatra"
require "sinatra/reloader"
require 'pry'
require "./lib/blog.rb"
require "./lib/post.rb"
enable :sessions


blog = Blog.new

blog.add_post(Post.new("Welcome to the absolute nothing","I am nothing.<br/> I'll never be anything.<br/>I couldn't want to be something.<br/>Apart from that, I have in me all the dreams in the world.<br/><br/><b>Fernando Pessoa</b>"))
blog.add_post(Post.new("Still nothing really","We can regard our life as a uselessly disturbing episode in the blissful repose of nothingness.<br/><br><b>Arthur Schopenhauer</b>"))



get "/" do 

    @list_of_posts = blog.latest_posts
	erb(:ironblog)

end

get "/post/:url" do
	@post = blog.list_of_posts.find {|post| post.url == params[:url].to_s}
	erb(:post)	

end

get "/create_post" do
	erb(:create_post)
end

post "/create_post" do

	blog.add_post(Post.new(params[:blog_title],params[:blog_text]))
	redirect to "/"

end


get "/edit" do
	@list_of_posts = blog.latest_posts
	erb(:edit)
end


get "/edit_post/:url" do
	@post = blog.list_of_posts.find {|post| post.url == params[:url].to_s}
	session[:post] = @post
	erb(:edit_post)

end

post "/edit_post" do

	@post = session[:post]
	@post.update(params[:blog_title],params[:blog_text])
	@list_of_posts = blog.latest_posts
	erb(:ironblog)
	redirect to "/"

end