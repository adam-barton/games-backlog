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

    if params[:name] != "" && params[:system] != ""
    @game = Game.create(params)
    redirect "/games"
    else 
      flash[:message] = "Please enter a valid name/system."
        redirect "/games/new"
      end
  end
  
    get '/games/:id/edit' do
    redirect_if_not_logged_in
    @game = Game.find_by_id(params[:id])
    
      if @game && @game.user == current_user
        erb :'/games/edit'    
      else
        redirect "/games"
      end
  end
  
  patch '/games/:id' do

    @game = Game.find_by_id(params[:id])
    if @game && @game.user == current_user
      @game.name = params[:name]
      @game.system = params[:system]
      @game.priority = params[:priority]
      @game.user_id = current_user.id
      @game.save 
      
      flash[:message] = "Successfully updated #{@game.name}."
      
      redirect "/games"
    else 
      
      flash[:message] = "You do not have access to that game."
       redirect "/games"
      end
  end
  
  get '/games/:id/delete' do
    redirect_if_not_logged_in
    @game = Game.find_by_id(params[:id])
      if @game.user_id == current_user.id
        @game.delete
        redirect "/games"
      else
        redirect "/games"
      end
  end
     
  
end