require 'uri'
require 'net/http'

class PostsController < ApplicationController
  def index
    @posts = Post.all
    # 自分の投稿だけなら
    # @posts = current_user.posts
    @maps = Map.all

    uri = URI('https://spla2.yuu26.com/schedule')
    @res = Net::HTTP.get_response(uri)
  end

  def show
    @post = Post.find(params[:id])
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
    # 武器idの決定。最終選択武器を取得。ないならメイン武器。さらになければ1つ目。
    if not params.has_key?('weapon')
      if current_user.last_select_weapon_id.present?
        weapon = current_user.last_select_weapon_id
      elsif current_user.favorite_weapon_id.present?
        weapon = current_user.favorite_weapon_id
      else
        weapon = 1
      end
    else
      weapon = params[:weapon]
    end

    post = Post.find_by(map: params[:map], rule: params[:rule], weapon: weapon)
    if post
      redirect_to edit_post_path(id: post.id)
    else
      redirect_to new_post_path(map: params[:map], rule: params[:rule], weapon: weapon)
    end
  end

  def search_post
    @posts = Post.where(map: params[:map], rule: params[:rule], weapon: params[:weapon])
  end

  private
    def def_params
      params.require(:post).permit(:description, :user_id, :map_id, :rule_id, :weapon_id)
    end
end
