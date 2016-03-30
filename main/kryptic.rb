

class Post < ActiveRecord::Base
  validates :domain, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end

# get ALL posts
get "/" do
  @posts = Post.order("created_at DESC")
  @domain = "Welcome."
  erb :"posts/index"
end

# create new post
get "/posts/create" do
  @domain = "Create post"
  @post = Post.new
  erb :"posts/create"
end
post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}", :notice => 'Congrats! Love the new post. (This message will disapear in 4 seconds.)'
  else
    redirect "posts/create", :error => 'Something went wrong. Try again. (This message will disapear in 4 seconds.)'
  end
end

# view post
get "/posts/:id" do
  @post = Post.find(params[:id])
  @domain = @post.domain
  erb :"posts/view"
end

# edit post
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  @domain = "Edit Form"
  erb :"posts/edit"
end
put "/posts/:id" do
  @post = Post.find(params[:id])
  @post.update(params[:post])
  redirect "/posts/#{@post.id}"
end

### Helper methods

#In order to dont allow html text
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

#This might not be needed
helpers do
  def domain
    if @domain
      "#{@domain}"
    else
      "Welcome."
    end
  end
end
