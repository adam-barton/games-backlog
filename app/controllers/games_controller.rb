class GamesController < ApplicationController
  
  get '/games/new' do
    redirect_if_not_logged_in

      erb :'/games/new'
  end
  
  get '/games' do
    redirect_if_not_logged_in
    @user = User.find_by("id" => session[:user_id])
    @games = @user.games.all
    
    erb :'/games/show'
  end
  
  
  post '/games' do
    redirect_if_not_logged_in
    @user = User.find_by("id" => session[:user_id])
    @game = Game.create(params)
    
    redirect "/games"
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
  
  post '/games/:id' do
    @game = Game.find_by(params[:id])
    @game.update("name" => params[:name], "system" => params[:system], "priority" => params[:priority])
    @game.user = current_user
    @game.save 
    
    flash[:message] = "Successfully updated game."
    
    redirect "/games"
  end
  
  get '/games/:id/delete' do
    redirect_if_not_logged_in
    @game = Game.find_by(params[:id])
      if @game.user_id == current_user.id
        @game.delete
        redirect "/games"
      else
        redirect "/games"
      end
  end
     
  
end