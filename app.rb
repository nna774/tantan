require 'sinatra'
require 'net/http'
require 'json'

def fetch(uri)
  res = Net::HTTP.post_form(URI.parse('https://graph.facebook.com/v2.10/'),
                            {id: uri, access_token: ENV['ACCESS_TOKEN']})
  JSON.load(res.body)
end

class App < Sinatra::Base
  get '/' do
    'Hello world!'
  end

  get '/ogp' do
    content_type :json
    fetch(params['uri']).to_json
  end

  get '/embed' do
    @ogp = fetch(params['uri'])
    erb :embed
  end
end
