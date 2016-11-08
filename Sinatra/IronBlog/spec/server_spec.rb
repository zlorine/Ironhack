require_relative "../server.rb"
require "rspec"
require"rack/test"

describe "My Web App" do
	include Rack::Test::Methods

	def app
		Sinatra::Application
end


it "should load the home page" do
	get '/'
	expect(last_response).to be_ok
end

it "should find nothing" do 
	get '/sciaobbello'
	expect(last_response).to_not be_ok
end

it "should redirect to home" do 
	post '/posts/still_nothing_really/delete'
	expect(last_response.redirect?).to be(true)
	follow_redirect!
	expect(last_request.path).to eq("/")
end

it "should redirect to no_post and then to the home page when an empty title is submitted" do 
	post '/posts/still_nothing_really/delete'
	expect(last_response.redirect?).to be(true)
	follow_redirect!
	expect(last_request.path).to eq("/")

	
	
end





end