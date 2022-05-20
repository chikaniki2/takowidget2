require "rails_helper"

RSpec.describe Post, type: :model do
  let!(:map1) { create(:map, name: "モンガラキャンプ場") }
  let(:rule1) { create(:rule, name: "ナワバリ") }
  let(:weapon1) { create(:weapon, name: "ワカバシューター") }
  let(:weapon2) { create(:weapon, name: "キャンピングシェルター") }
  let(:user1) { create(:user, name: "user1", password: "123456", nickname: "testuser1", favorite_weapon_id: weapon1.id) }
  let(:user2) { create(:user, name: "user2", password: "123456", nickname: "testuser2", favorite_weapon_id: weapon1.id) }
  let!(:testpost1) { create(:post, user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon1.id) }

  before do
    sign_in user1
  end

  context "正常に保存できるケース" do
    it "正常に登録できること" do
      success_post = Post.create(user_id: user1.id, map_id: map1.id, rule_id: rule1.id, weapon_id: weapon2.id)
      expect(success_post).to be_valid
    end
  end

  context "保存に失敗するケース" do
    it "user_idが未入力だと登録できないこと" do
      faile_post = Post.create(
        map_id: map1.id,
        rule_id: rule1.id,
        weapon_id: weapon1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:user_id]).to include("を入力してください")
    end

    it "map_idが未入力だと登録できないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        rule_id: rule1.id,
        weapon_id: weapon1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:map_id]).to include("を入力してください")
    end

    it "rule_idが未入力だと登録できないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        map_id: map1.id,
        weapon_id: weapon1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:rule_id]).to include("を入力してください")
    end

    it "weapon_idが未入力だと登録できないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        map_id: map1.id,
        rule_id: rule1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:weapon_id]).to include("を入力してください")
    end

    it "存在しないmap_idのメモは保存できないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        map_id: map1.id + 1,
        rule_id: rule1.id,
        weapon_id: weapon1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:map_id]).to include("は存在しません")
    end

    it "存在しないrule_idのメモは保存できないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        map_id: map1.id,
        rule_id: rule1.id + 1,
        weapon_id: weapon1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:rule_id]).to include("は存在しません")
    end

    it "存在しないweapon_idのメモは保存できないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        map_id: map1.id,
        rule_id: rule1.id,
        weapon_id: weapon1.id + 1,
      )
      faile_post.valid?
      expect(faile_post.errors[:weapon_id]).to include("は存在しません")
    end

    it "既に同じidで投稿が存在する場合は、createで新規登録はできないこと" do
      faile_post = Post.create(
        user_id: user1.id,
        map_id: map1.id,
        rule_id: rule1.id,
        weapon_id: weapon1.id,
      )
      faile_post.valid?
      expect(faile_post.errors[:user_id]).to include("はすでに存在します")
    end
  end
end
