class PostsController < ApplicationController
  def index
    @posts = Post.all
    # @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(def_params)
  if @post.save
    flash[:notice] = "新規登録しました"
    redirect_to :posts
  else
    render "new"
  end
end


  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  private
    def def_params
      params.require(:post).permit(:description, :user_id, :map_id, :rule_id, :weapon_id)
    end
end
