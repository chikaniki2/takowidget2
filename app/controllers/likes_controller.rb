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
    likes = Post.joins(:likes).where(likes: { user_id: current_user.id })
    @posts = likes.where(map_id: params[:map_id], rule_id: params[:rule_id], weapon_id: params[:weapon_id])
  end

  def list_all
    @posts = Post.joins(:likes).where(likes: { user_id: current_user.id })
  end

end
