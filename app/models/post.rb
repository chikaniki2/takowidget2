class Post < ApplicationRecord
  belongs_to :user
  belongs_to :map
  belongs_to :rule
  belongs_to :weapon
  has_many :likes, dependent: :destroy # 投稿削除時にいいねも削除
  has_rich_text :description

  validates :user_id, presence: true
  validates :rule_id, presence: true
  validates :weapon_id, presence: true
end
