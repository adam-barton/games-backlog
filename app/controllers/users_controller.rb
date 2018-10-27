class UsersController < ApplicationController
  
  get '/users/new' do
    erb :'users/new'
  end
  
  get '/users/login' do
    erb :'/users/login'
  end
  
  post '/users' do
    @user = User.create(params)
     session[:user_id] = @user.id
      redirect "/users"
  end
  

  
  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
        if @user.id == current_user
          erb :"/users/show"
        else 
          redirect :"/users/login"
        end
    else
     redirect :"/users/login"
    end
  end
  
  
end