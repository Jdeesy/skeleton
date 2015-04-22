get '/users/login' do
  @errors = nil
  erb :"users/login"
end

post '/users/login' do
  puts params
  username = params[:user][:username]
  input_password = params[:user][:password]

  @user = User.authenticate(username, input_password)
  @user = User.find_by(username: username)

  if User.authenticate(username, input_password)
    session[:user_id] = @user.id
    redirect homepage
  else
    @errors = ["Invalid email/password"]
    erb :index
  end
end

get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users/new' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect homepage
  else
    @user
    @errors = @user.errors.full_messages
    erb :"users/new"
  end
end

get '/users/logout' do
  session[:user_id] = nil
  redirect homepage
end

get '/users/:id' do
  erb :"users/show"
end