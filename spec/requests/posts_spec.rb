require "rails_helper"
require "factory_bot_rails"

RSpec.describe "Posts", type: :request do
  let(:map1) { create(:map, name: "モンガラキャンプ場") }
  let(:map2) { create(:map, name: "タチウオパーキング") }
  let(:rule1) { create(:rule, name: "ナワバリ") }
  let(:weapon1) { create(:weapon, name: "ワカバシューター") }
  let(:weapon2) { create(:weapon, name: "キャンピングシェルター") }

  let(:user1) { create(:user, name: "testuser1", password: "123456", favorite_weapon_id: weapon1.id) }
  let(:user2) { create(:user, name: "testuser2", password: "123456", favorite_weapon_id: weapon2.id) }

  let!(:postdata_u1_m1_r1_w1) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon1.id, description: "テスト投稿_u1_m1_r1_w1") }
  let!(:postdata_u1_m1_r1_w2) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon2.id, description: "テスト投稿_u1_m1_r1_w2") }

  let!(:postdata_u2_m1_r1_w2) { create(:post, user_id: user2.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon1.id, description: "テスト投稿_u2_m1_r1_w2") }

  describe "GET Post#index" do
    before do
      get posts_path
    end

    it "正常に表示できること" do
      expect(response).to have_http_status(200)
    end

    it "APIから再形成したスケジュールデータを取得できていること" do
      # サーバーレスポンスなので、形成済みのデータが来るはず
      expect(response.body).to include "ガチエリア"
    end
  end

  describe "GET Post#other index" do
    it "未ログインでindex以外にアクセスするとログインページにリダイレクトされること" do
      get post_path(Post.first.id)
      expect(response).to have_http_status(302)
    end
  end

  describe "GET search" do
    before do
      sign_in user1
    end
    it "該当の投稿がない場合はnewにリダイレクトされること" do
      # search = u1_m2_r1_w1
      get search_posts_path, params: { map: map2.id, rule: rule1.id, weapon: weapon1.id }
      expect(response).to redirect_to new_post_path(map: map2.id, rule: rule1.id, weapon: weapon1.id)
    end

    it "該当の投稿がある場合はeditにリダイレクトされること" do
      # search = u1_m1_r1_w1
      get search_posts_path, params: { map: map1.id, rule: rule1.id, weapon: weapon1.id }
      expect(response).to redirect_to edit_post_path(postdata_u1_m1_r1_w1.id)
    end

    it "getでweapon指定がない時は、Userのお気に入りを参照して移動すること" do
      # search = u1_m1_r1 + w1
      get search_posts_path, params: { map: map1.id, rule: rule1.id }
      expect(response).to redirect_to edit_post_path(postdata_u1_m1_r1_w1.id)
    end

    it "getでweapon指定がなく、Userの最終選択ブキがある場合はそちらを優先参照して移動すること" do
      # search = u1_m1_r1 + w2
      user1.last_select_weapon_id = weapon2.id
      get search_posts_path, params: { map: map1.id, rule: rule1.id }
      expect(response).to redirect_to edit_post_path(postdata_u1_m1_r1_w2.id)
    end
  end

  describe "GET new" do
    before do
      sign_in user1
    end
    it "プルダウンに表示するマップ、ルール、ブキ名が取得できていること" do
      get new_post_path(map: map2.id, rule: rule1.id, weapon: weapon1.id)
      expect(response.body).to include(map2.name, rule1.name, weapon1.name)
    end
  end

  describe "GET edit" do
    before do
      sign_in user1
    end
    context "自分の投稿を編集するケース" do
      before do
        get edit_post_path(postdata_u1_m1_r1_w1)
      end

      it "プルダウンに表示するマップ、ルール、ブキ名が取得できていること" do
        expect(response.body).to include(map1.name, rule1.name, weapon1.name)
      end

      it "投稿内容が取得できていること" do
        expect(response.body).to include "テスト投稿_u1_m1_r1_w1"
      end
    end

    context "他人の投稿を編集しようとするケース" do
      it "別のユーザーの投稿を編集しようとしたら、showにリダイレクトされること" do
        get edit_post_path(postdata_u2_m1_r1_w2)
        expect(response).to redirect_to post_path(postdata_u2_m1_r1_w2.id)
      end
    end
  end
end
