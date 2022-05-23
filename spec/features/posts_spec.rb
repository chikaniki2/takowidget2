require "rails_helper"

# rubocop:disable Metrics/BlockLength
RSpec.feature "Users" do
  given(:map1) { create(:map, name: "モンガラキャンプ場") }
  given(:map2) { create(:map, name: "タチウオパーキング") }
  given(:rule1) { create(:rule, name: "ナワバリ") }
  given(:weapon1) { create(:weapon, name: "ワカバシューター") }
  given(:weapon2) { create(:weapon, name: "キャンピングシェルター") }

  given(:user1) { create(:user, name: "testuser1", password: "123456", nickname: "user1", favorite_weapon_id: weapon1.id) }

  given!(:postdata_u1_m1_r1_w1) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon1.id) }
  given!(:postdata_u1_m1_r1_w2) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon2.id) }

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
        expect(find("#post_map_id").value).to eq(map1.id.to_s)
        expect(find("#post_rule_id").value).to eq(rule1.id.to_s)
        expect(find("#post_weapon_id").value).to eq(weapon1.id.to_s)
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

  feature "post#new", js: true do
    background do
      sign_in user1
    end
    scenario "プルダウンを操作したとき、投稿データがないなら、該当パラメータのnewに移動すること" do
      visit new_post_path(map: map2.id, rule: rule1.id, weapon: weapon1.id)
      select weapon2.name.to_s, from: "post[weapon_id]"
      page.evaluate_script("document.getElementById('post_weapon_id').dispatchEvent(new Event('change'))")
      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq new_post_path(map: map2.id, rule: rule1.id, weapon: weapon2.id)
    end

    scenario "プルダウンを操作したとき、投稿データがあるなら、editに移動すること" do
      visit new_post_path(map: map2.id, rule: rule1.id, weapon: weapon1.id)
      select map1.name.to_s, from: "post[map_id]"
      page.evaluate_script("document.getElementById('post_map_id').dispatchEvent(new Event('change'))")
      expect(current_path).to eq edit_post_path(postdata_u1_m1_r1_w1.id)
    end

    scenario "保存して閉じるを押したら、投稿が保存されてindexへ移動すること" do
      visit new_post_path(map: map2.id, rule: rule1.id, weapon: weapon1.id)
      find("#button_submit").click
      expect(page).to have_content "メモを更新しました"
      expect(current_path).to eq posts_path
    end
  end

  feature "post#edit", js: true do
    background do
      sign_in user1
    end
    scenario "プルダウンを操作したとき、投稿データがあるなら該当のeditへ移動すること" do
      visit edit_post_path(postdata_u1_m1_r1_w1.id)
      select weapon2.name.to_s, from: "post[weapon_id]"
      page.evaluate_script("document.getElementById('post_weapon_id').dispatchEvent(new Event('change'))")
      expect(current_path).to eq edit_post_path(postdata_u1_m1_r1_w2.id)
    end

    scenario "保存して閉じるを押したら、投稿が保存されてindexへ移動すること" do
      visit edit_post_path(postdata_u1_m1_r1_w1.id)
      find("#button_submit").click
      expect(page).to have_content "メモを更新しました"
      expect(current_path).to eq posts_path
    end

    scenario "メモを編集して更新できること" do
      visit edit_post_path(postdata_u1_m1_r1_w1.id)
      fill_in_rich_text_area "post_description", with: "編集テスト"
      find("#button_submit").click
      expect(page).to have_content "メモを更新しました"
      visit edit_post_path(postdata_u1_m1_r1_w1.id)
      expect(page).to have_content "編集テスト"
    end
  end
end
# rubocop:enable Metrics/BlockLength
