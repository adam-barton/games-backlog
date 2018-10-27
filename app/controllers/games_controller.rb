class GamesController < ApplicationController
  
  get '/games' do
    erb :'games/index'    
  end
  
end