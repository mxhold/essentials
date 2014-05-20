class Comparison < ActiveRecord::Base
  belongs_to :winning_comparand, class_name: 'Comparand'
  has_one :winning_item, through: :winning_comparand, class_name: 'Item', source: :item
  has_many :comparands

  validate :must_have_exactly_two_comparands
  validate :winner_must_be_one_of_comparands

  def draw?
    !winning_comparand
  end

  def item1
    comparands.first.item
  end

  def item2
    comparands.last.item
  end

  def result
    case winning_item
    when nil
      0
    when item1
      1
    when item2
      2
    end
  end

  private

  def must_have_exactly_two_comparands
    unless comparands.size == 2
      errors.add(:base, "must have exactly two comparands")
    end
  end

  def winner_must_be_one_of_comparands
    unless winning_comparand.blank? || comparands.include?(winning_comparand)
      errors.add(:winning_comparand_id, "must be one of the comparands being compared")
    end
  end

  def comparands_include_item?(item)
    comparands.map(&:item_id).include?(item.id)
  end
end
