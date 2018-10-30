require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash
  
  get '/users/new' do
    if logged_in? 
      redirect "/games"
    else
    erb :'users/new'
  end
  end
  
  get '/users/login' do
      if logged_in? 
      redirect "/games"
    else 
    session.clear
    erb :'/users/login'
    end
  end
  
    post '/users' do
      if !User.find_by(name: params[:name])
    @user = User.create(params)
     session[:user_id] = @user.id
      redirect "/games"
    else
      flash[:message] = "An account with that username already exists. Please sign in."
      
      redirect "/users/login"
    end
  end
  
  post '/users/login' do
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/games" 
    else
      flash[:message] = "The username or password did not match our records. Please try again"
      redirect "/"
    end
  end
  
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/'
    else
      redirect to '/'
    end
  end
  
end