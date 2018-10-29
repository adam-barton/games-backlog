class GamesController < ApplicationController
  
  get '/games/new' do
    redirect_if_not_logged_in

      erb :'/games/new'
  end
  
  get '/games' do
    redirect_if_not_logged_in
    @user = current_user
    
    erb :'/games/show'
  end
  
  get '/games/:id/edit' do
    redirect_if_not_logged_in
    @game = Game.find(params[:id])
      if @game && @game.user == current_user
        erb :'/games/edit'    
      else
        redirect "/games"
      end
  end
  
  post '/games' do
    redirect_if_not_logged_in
    @user = current_user
    @game = Game.create(params)
    
    redirect "/games"
  end
  
  post '/games/:id' do
    @game = Game.find_by(params[:id])
    binding.pry
    @game.update("name" => params[:name], "system" => params[:system], "priority" => params[:priority])
    @game.save 
    
    flash[:message] = "Successfully updated game."
    
    redirect "/games"
  end
     
  
end