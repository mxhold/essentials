class Comparison < ActiveRecord::Base
  belongs_to :item1, class_name: 'Item'
  belongs_to :item2, class_name: 'Item'

  validates :item1, :item2, presence: true
  validates :result, inclusion: { 
    in: [0, 1, 2], 
    message: "is not a valid result"
  }

  validate :item1_and_item2_must_be_different

  def winning_item
    case result
    when 0
      nil
    when 1
      item1
    when 2
      item2
    end
  end

  def winning_item=(item)
    case item
    when nil
      self.result = 0
    when item1
      self.result = 1
    when item2
      self.result = 2
    end
  end

  def draw?
    result == 0
  end

  private
  
  def item1_and_item2_must_be_different
    if item1 == item2
      errors.add(:base, "items must be different")
    end
  end
end
