class LikesController < ApplicationController
  protect_from_forgery :except => [:destroy]

  def create
    @post = Post.find_by(id: params[:post_id])
    like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    like.save
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
  end

  #rails6.1ではdeleteを投げるとgetになってしまうので、postで動く独自削除メソッドで代用
  def dlt
    @post = Post.find_by(id: params[:post_id])
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
  end

  def list
    likes = current_user.likes.map do |like|
      Post.find(like.post_id)
    end
    @posts = likes
    #@posts = likes.where(map_id: params[:map_id], rule_id: params[:rule_id], weapon_id: params[:weapon_id])
  end

  def list_all
    @posts = current_user.likes.map do |like|
      Post.find_by(id: like.post_id)
    end
  end

end
