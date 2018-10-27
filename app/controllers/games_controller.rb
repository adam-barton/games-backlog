class GamesController < ApplicationController
  
  get '/games/new' do
    redirect_if_not_logged_in

      erb :'/games/new'
  end
  
  post '/games' do
    redirect_if_not_logged_in
    @user = current_user
    @game = Game.create(params)
    
    redirect "/users/#{@user.slug}"
  end
     
  
end