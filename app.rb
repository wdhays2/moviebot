# My Movie Slack Bot

require 'sinatra'
require 'httparty'
require 'json'

post '/info' do
  return if params[:token] != ENV['SLACK_TOKEN']

  text = params[:text]
  movie_url = 'http://www.omdbapi.com/?t=%22Jurassic%20Park%22'

  case text
  when 'info'
      resp = HTTParty.get(movie_url)
      resp = JSON.parse resp.body
      respond_message "Title: #{resp['Title']} \n\ Director: #{resp['Director']}"
  end
end

def respond_message message
  content_type :json
  {:text => message}.to_json
end
