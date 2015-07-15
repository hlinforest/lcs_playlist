# Homepage (Root path)
helpers do
  def get_embed_url(url) 
    temp1 = url.split('=')
    temp2 = "https://www.youtube.com/embed/" + temp1[1] #doesnt work if video doesnt start at beginning
  end

  def current_user
    if session[:user_id]
      if @current_user.nil?
        @current_user = User.find(session[:user_id])
      end
    end
    @current_user
  end

end

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(email: params[:email])

  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    @message = "Login failed"
    erb :login
  end
end

get '/register' do
  erb :register
end

post '/register' do
  user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    password: params[:password]
    )
  user.save
  session[:user_id] = user.id
  redirect '/'
end

get '/videos' do
  @videos = Video.all
  erb :'videos/index'
end

get '/videos/new' do
  erb :'videos/new'
end

post '/videos' do
  @video = Video.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
    )
  @video.save
  redirect '/videos'
end

get '/logout' do
  session.clear
  redirect '/login'
end