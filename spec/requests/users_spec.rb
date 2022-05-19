require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:weapon1) { create(:weapon, name: "ワカバシューター") }
  let!(:user1) { create(:user, name: "user1", password: "123456", nickname: "user1", favorite_weapon_id: weapon1.id) }

  describe "sign_in" do
    context "ログインしていない場合" do
      it "ログイン画面に移動したとき、正常に表示されるか" do
        get new_user_session_path
        expect(response).to have_http_status(200)
      end

      it "ユーザー登録画面に移動した時、正常に表示されるか" do
        get new_user_registration_path
        expect(response).to have_http_status(200)
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user1
      end
      it "ログイン画面に移動すると、トップページにリダイレクトされること" do
        get new_user_session_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end

      it "ユーザー登録画面に移動すると、トップページにリダイレクトされること" do
        get new_user_registration_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end

      it "ログアウト後はトップページにリダイレクトされること" do
        delete destroy_user_session_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "edit" do
    it "ログインしていないなら、ログイン画面にリダイレクトされること" do
      get edit_user_registration_path(id: user1.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "ログインしているなら、アカウント設定ページが表示されること" do
      sign_in user1
      get edit_user_registration_path(id: user1.id)
      expect(response.body).to include "アカウント設定"
    end
  end

  describe "profile" do
    it "ログインしていないなら、ログイン画面にリダイレクトされること" do
      get profile_users_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "ログインしているなら、プロフィール編集ページが表示されること" do
      sign_in user1
      get profile_users_path
      expect(response.body).to include "プロフィール編集"
    end
  end
end
