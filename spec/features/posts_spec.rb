require "rails_helper"

RSpec.feature "Users" do
  include Devise::Test::IntegrationHelpers
  given(:map1) { create(:map, name: "モンガラキャンプ場") }
  given(:map2) { create(:map, name: "タチウオパーキング") }
  given(:rule1) { create(:rule, name: "ナワバリ") }
  given(:weapon1) { create(:weapon, name: "ワカバシューター") }
  given(:weapon2) { create(:weapon, name: "キャンピングシェルター") }

  given(:user1) { create(:user, name: "testuser1", password: "123456", favorite_weapon_id: weapon1.id) }
  given(:user2) { create(:user, name: "testuser2", password: "123456", favorite_weapon_id: weapon2.id) }

  given!(:postdata_u1_m1_r1_w1) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon1.id, description: "テスト投稿_u1_m1_r1_w1") }
  given!(:postdata_u1_m1_r1_w2) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon2.id, description: "テスト投稿_u1_m1_r1_w2") }

  given!(:postdata_u2_m1_r1_w2) { create(:post, user_id: user2.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon1.id, description: "テスト投稿_u2_m1_r1_w2") }

  feature "post#index" do
    context "ログイン前の場合" do
      scenario "スケジュールとマップ一覧が表示されること" do
        visit posts_path
        expect(page).to have_content "モンガラキャンプ場"
        expect(page).to have_content "ガチエリア"
      end

      scenario "マップ名をクリックすると、ログインを要求されること" do
        visit posts_path
        find("#maplist a:nth-of-type(1)").click
        expect(page).to have_content "ログインもしくはアカウント登録してください。"
      end
    end

    context "ログイン後の場合" do
      background do
        sign_in user1
      end

      scenario "ログイン済みでマップ名をクリックすると、投稿編集に移動し、プルダウンの項目が自動選択された状態になっていること" do
        visit posts_path
        find("#maplist a:nth-of-type(1)").click
        visit edit_post_path(postdata_u1_m1_r1_w1.id)
        expect(find("#post_map_id").value).to eq("#{map1.id}")
        expect(find("#post_rule_id").value).to eq("#{rule1.id}")
        expect(find("#post_weapon_id").value).to eq("#{weapon1.id}")
      end

      scenario "ログイン済みならナビメニューから各リンクに正常にアクセスできること" do
        visit posts_path
        click_link "スケジュール"
        expect(page).to have_selector "div", text: "スケジュール"

        click_link "マップ一覧"
        expect(page).to have_selector "div", text: "マップ一覧"

        click_link "プロフィール編集"
        expect(page).to have_selector "h3", text: "プロフィール編集"

        click_link "アカウント設定"
        expect(page).to have_selector "h2", text: "アカウント設定"

        click_link "ログアウト"
        expect(page).to have_selector "div", text: "スケジュール"
      end
    end
  end
end
