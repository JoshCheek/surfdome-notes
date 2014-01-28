require 'sinatra'

class ThingWithForm < Sinatra::Base
  get '/' do
    "<a href='/form'>Fill out the Form</a>"
  end

  get "/form" do
    "<form action='/form' method='post'>
      <input type='text' name='the_data'>
      <input type='submit'>
    </form>"
  end

  post "/form" do
    "You submitted #{params[:the_data].inspect}"
  end
end