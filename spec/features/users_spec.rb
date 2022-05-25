require "rails_helper"

RSpec.feature "Users" do
  given!(:weapon1) { create(:weapon, name: "ワカバシューター") }
  given!(:weapon2) { create(:weapon, name: "キャンピングシェルター") }
  given!(:user1) { create(:user, name: "user1", password: "123456", nickname: "testuser1", favorite_weapon_id: weapon1.id) }
  given!(:user2) { create(:user, name: "user2", password: "123456", nickname: "testuser2", favorite_weapon_id: weapon2.id) }

  feature "user_session#new" do
    scenario "ログインに成功すること" do
      visit new_user_session_path
      fill_in "user[name]", with: "user1"
      fill_in "user[password]", with: "123456"
      click_button "ログイン"
      expect(page).to have_content "ログインしました"
    end
  end

  feature "user_registration#new" do
    scenario "新規ユーザー登録できること" do
      visit new_user_registration_path
      fill_in "user[name]", with: "user3"
      fill_in "user[nickname]", with: "testuser3"
      fill_in "user[password]", with: "123456"
      fill_in "user[password_confirmation]", with: "123456"
      select "キャンピングシェルター", from: "user[favorite_weapon_id]"
      click_button "新規登録"
      expect(page).to have_content "アカウント登録が完了しました。"
    end
  end

  feature "user_registration#edit" do
    background do
      sign_in user1
      visit edit_user_registration_path(user1.id)
    end

    scenario "nameを変更できること" do
      fill_in "user[name]", with: "testuser3"
      fill_in "user[current_password]", with: "123456"
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。"
    end

    scenario "passwordを変更できること" do
      fill_in "user[current_password]", with: "123456"
      fill_in "user[password]", with: "654321"
      fill_in "user[password_confirmation]", with: "654321"
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。"
    end
  end

  feature "user#profile" do
    background do
      sign_in user1
      visit profile_users_path(user1.id)
    end

    scenario "nicknameが変更できること" do
      fill_in "user[nickname]", with: "testuser4"
      click_button "更新"
      expect(page).to have_content "更新しました"
    end

    scenario "favorite_weapon_idが変更できること" do
      select "キャンピングシェルター", from: "user[favorite_weapon_id]"
      click_button "更新"
      expect(page).to have_content "更新しました"
    end

    scenario "nicknameが重複する場合は更新できないこと" do
      fill_in "user[nickname]", with: "testuser2"
      click_button "更新"
      expect(page).to have_content "更新できませんでした"
    end
  end
end
