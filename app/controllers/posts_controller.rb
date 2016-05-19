class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all #.order("created_at DESC")
    render 'index.html.erb'
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    render 'new.html.erb'
  end

  def create
    @post = Post.create(id: params[:id],
                     title: params[:title],
                     content: params[:content],
                     user_id: current_user.id
                    )

    if @post.save
      redirect_to '/posts/#{@post.id}'
    else
      render 'new.html.erb'
    end
  end

  def edit
    post_id = params[:id]
    @post = Post.find_by(id: post_id)
    render 'edit.html.erb'
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(title: params[:title],
                    content: params[:content]
                   )
    redirect_to "/posts/#{@post.id}"
    else
      render "edit.html.erb"
    end
  end  
  def destroy
    @post.destroy
    redirect_to @post
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
