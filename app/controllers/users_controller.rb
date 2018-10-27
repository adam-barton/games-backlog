class UsersController < ApplicationController
  
  get '/users/new' do
    erb :'users/new'
  end
  
  post '/users' do
    @user = User.create(params)
     session[:user_id] = @user.id
      redirect "/users/#{@user.username.slug}"
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
  end
  
  
end