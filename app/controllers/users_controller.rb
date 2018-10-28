require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash
  
  get '/users/new' do
    erb :'users/new'
  end
  
  get '/users/login' do
    erb :'/users/login'
  end
  
  get '/users/:slug' do
    redirect_if_not_logged_in
      @user = User.find_by_slug(params[:slug])
        if @user == current_user
          erb :"/users/show"
        else 
          redirect :"/users/login"
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
    end
  end
  
  
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/users/login'
    else
      redirect to '/'
    end
  end
  
end