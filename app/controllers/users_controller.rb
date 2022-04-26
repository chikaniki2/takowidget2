class UsersController < ApplicationController

  def profile
    if !user_signed_in?
      redirect_to "/users/sign_in" 
    else
      @user = current_user
      @weapons = Weapon.all
      @favorite_weapon_id = current_user.favorite_weapon_id
    end
  end

  def update
    @user = current_user
      if @user.update(def_params)
        @user.update_attribute(:last_select_weapon_id, @user.favorite_weapon_id)
        flash[:notice] = "更新しました"
        redirect_to("/users/profile")
      else
        flash[:alert] = "更新できませんでした"
        redirect_to("/users/profile")
      end
  end

  private
    def def_params
      params.require(:user).permit(:name, :description, :favorite_weapon_id)
    end
end
