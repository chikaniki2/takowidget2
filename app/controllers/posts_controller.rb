class PostsController < ApplicationController
  def index
    @posts = Post.all
    # 自分の投稿だけなら
    # @posts = current_user.posts
  end

  def new
    @post = Post.new
    @maps = Map.all
    @rules = Rule.all
    @weapons = Weapon.all
    @map_id = params[:map]
    @rule_id = params[:rule]
    @weapon_id = params[:weapon]
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
    # TODO current userのみが編集できるようにすること
    @post = Post.find(params[:id])
    @maps = Map.all
    @rules = Rule.all
    @weapons = Weapon.all
  end

def update
    @post = Post.find(params[:id])
      if @post.update(def_params) 
        flash[:notice] = "ID「#{@post.id}」の情報を更新しました"
        redirect_to :posts
      else
        render "edit"
      end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "削除しました"
    redirect_to :posts
  end

  def search
    post = Post.find_by(map: params[:map], rule: params[:rule], weapon: params[:weapon])
    if post
      redirect_to edit_post_path(id: post.id)
    else
      redirect_to new_post_path(map: params[:map], rule: params[:rule], weapon: params[:weapon])
    end
  end

  private
    def def_params
      params.require(:post).permit(:description, :user_id, :map_id, :rule_id, :weapon_id)
    end
end
