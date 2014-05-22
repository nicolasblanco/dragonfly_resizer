require 'sinatra'
require 'dragonfly'

app = Dragonfly.app(:images).configure_with(:imagemagick)

get '/hi' do
  "Hello World!"
end

get '/images/:size.:format' do |size, format|
  app.fetch_url(Rack::Utils.unescape(params[:url])).thumb(size).encode(format).to_response(env)
end
