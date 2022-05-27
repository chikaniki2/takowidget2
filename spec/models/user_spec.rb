require "rails_helper"

RSpec.describe Users, type: :model do
  let(:weapon1) { create(:weapon, name: "ワカバシューター") }

  describe "new" do
    context "正常に登録できるケース" do
      it "ユーザーID、ニックネーム、パスワード(6文字以上)が入力されていれば新規登録できること" do
        user = create(:user, name: "user1", password: "123456", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        expect(user).to be_valid
      end
    end

    context "バリデーションエラーで登録できないケース" do
      it "nameが未入力だと登録できないこと" do
        faile_user = User.create(name: "", password: "123456", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        faile_user.valid?
        expect(faile_user.errors[:name]).to include("を入力してください")
      end

      it "nameが重複していると登録できないこと" do
        User.create(name: "user1", password: "123456", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        faile_user = User.create(name: "user1", password: "123456", nickname: "nickname2", favorite_weapon_id: weapon1.id)
        expect(faile_user.errors[:name]).to include("はすでに存在します")
      end

      it "ニックネームが未入力だと登録できないこと" do
        faile_user = User.create(name: "user1", password: "123456", nickname: "", favorite_weapon_id: weapon1.id)
        expect(faile_user.errors[:nickname]).to include("を入力してください")
      end

      it "ニックネームが重複していると登録できないこと" do
        User.create(name: "user1", password: "123456", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        faile_user = User.create(name: "user2", password: "123456", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        expect(faile_user.errors[:nickname]).to include("はすでに存在します")
      end

      it "パスワードが未入力だと登録できないこと" do
        faile_user = User.create(name: "user1", password: "", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        expect(faile_user.errors[:password]).to include("を入力してください")
      end

      it "パスワードが5文字以下だと登録できないこと" do
        faile_user = User.create(name: "user1", password: "12345", nickname: "nickname1", favorite_weapon_id: weapon1.id)
        expect(faile_user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end
end
