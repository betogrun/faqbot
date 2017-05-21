require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require 'byebug' unless ENV['RACK_ENV'] == 'production'
require './config/database'

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  get '/sinatra' do
    'Hello world Sinatra!'
  end

  post '/webhook' do
    result = JSON.parse(request.body.read)["result"]
    if result["contexts"].present?
      response = InterpretService.call(result["action"], result["contexts"][0]["parameters"])
    else
      response = InterpretService.call(result["action"], result["parameters"])
    end

    content_type :json
    {
      "unfurl_links": "true",
      "speech": response,
      "displayText": response,
      "source": "FAQBot"
    }.to_json

  end
end
