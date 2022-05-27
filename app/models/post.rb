class Post < ApplicationRecord
  belongs_to :user
  belongs_to :map
  belongs_to :rule
  belongs_to :weapon
  has_many :likes, dependent: :destroy # 投稿削除時にいいねも削除
  has_rich_text :description

  validates :user_id, { presence: true, uniqueness: { scope: %i[map_id rule_id weapon_id] } }
  validates :map_id, presence: true
  validates :rule_id, presence: true
  validates :weapon_id, presence: true

  validate :record_notfound

  def record_notfound
    if Map.find_by(id: map_id).blank?
      errors.add(:map_id, "は存在しません")
    elsif Rule.find_by(id: rule_id).blank?
      errors.add(:rule_id, "は存在しません")
    elsif Weapon.find_by(id: weapon_id).blank?
      errors.add(:weapon_id, "は存在しません")
    end
  end
end
