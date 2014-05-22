require 'sinatra'
require 'dragonfly'

app = Dragonfly.app(:images).configure_with(:imagemagick)

get '/images/:size.:format' do |size, format|
  format_response(app.fetch_url(Rack::Utils.unescape(params[:url])).thumb(size).encode(format).to_response(env))
end

private
def format_response(res)
  if res && res.is_a?(Array) && res[0] == 500
    [404, {"Content-Type"=>"text/plain"}, ["Not found"]]
  else
    res
  end
end
