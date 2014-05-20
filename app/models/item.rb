class Item < ActiveRecord::Base
  validates :name, presence: true

  def to_s
    name
  end

  def rating
    self[:rating] || 1000
  end
end
