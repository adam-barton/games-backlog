class UsersController < ApplicationController
  
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
    @user = User.create(params)
     session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
  end
  
  post '/users/login' do
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"  
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