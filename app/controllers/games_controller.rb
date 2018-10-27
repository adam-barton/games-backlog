class GamesController < ApplicationController
  
  get '/games/new' do
    if logged_in?
      
      erb :'/games/new'
    else
      redirect "/users/login"
    end
  end
  
  post '/games' do
    @user = current_user
    @game = Game.create(params)
    
    redirect "/users/#{@user.slug}"
  end
     
  
end