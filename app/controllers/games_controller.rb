class GamesController < ApplicationController
  
   get '/games' do
    redirect_if_not_logged_in
    @user = User.find_by("id" => current_user.id)
    @games = @user.games.all
    
    erb :'/games/show'
  end
  
  get '/games/new' do
    redirect_if_not_logged_in
    
    @user = User.find_by("id" => current_user.id)
  

      erb :'/games/new'
  end
  
  
  post '/games' do
    redirect_if_not_logged_in
    @user = User.find_by("id" => session[:user_id])
    @game = Game.create(params)
    binding.pry
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
  
  patch '/games/:id' do
    @game = Game.find_by_id(params[:id])
    @game.name = params[:name]
    @game.system = params[:system]
    @game.priority = params[:priority]
    @game.user_id = current_user.id
    @game.save 
    
    flash[:message] = "Successfully updated #{@game.name}."
    
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