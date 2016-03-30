

class Post < ActiveRecord::Base
  validates :domain, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end

#When Creating a post
get "/posts/create" do
 @domain = "Create post"
 @post = Post.new
 erb :"posts/create"
end

get "/" do
  @posts = Post.order("created_at DESC")
  @domain = "Welcome."
  erb :"posts/index"
end

get "/posts/:id" do
 @post = Post.find(params[:id])
 @domain = @post.domain
 erb :"posts/view"
end


# POST requests
post "/posts" do
 @post = Post.new(params[:post])
 if @post.save
   redirect "posts/#{@post.id}", :notice => 'Congrats! Love the new post. (This message will disappear in 4 seconds.)'
 else
   redirect "posts/create", :error => 'Something went wrong. Try again. (This message will disappear in 4 seconds.)'
 end
end

#This might not be needed
helpers do
  def domain
    if @domain
      "#{@title}"
    else
      "Welcome."
    end
  end
end
