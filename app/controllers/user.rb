get '/sign-up' do
  erb :'sign-up'
end

post '/sign-up' do
  user = User.new(params)
  if user.save
    redirect '/'
  else
    @errors = user.errors.full_messages
    erb :'sign-up'
  end
end

get '/login' do 
  erb :login
end

post '/login' do
  email = params[:email]
  password = params[:password]
  user = User.find_by(email: email)
  if User.authenticate(email, password)
    session[:user_id] = user.id
    redirect "/"
  else
    @error = "Invalid login!"
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

