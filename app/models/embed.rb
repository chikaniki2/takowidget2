class Embed < ApplicationRecord
  include ActionText::Attachable

  validates :url, presence: true
  validates :raw_info, presence: true

  def html
    raw_info['fields']['html']
  end

  def raw_info
    JSON.parse(read_attribute(:raw_info))
  rescue StandardError
    {}
  end
end
