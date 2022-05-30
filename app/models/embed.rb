class Embed < ApplicationRecord
  include ActionText::Attachable
  
  validates :url, presence: true
  validates :raw_info, presence: true
  
  def html
    raw_info['fields']['html']
  end
  
  def raw_info
    begin
      JSON.parse(read_attribute(:raw_info))
    rescue
      {}
    end
  end
end
