class Post < ApplicationRecord
  belongs_to :user
  belongs_to :map
  belongs_to :rule
  belongs_to :weapon
end
