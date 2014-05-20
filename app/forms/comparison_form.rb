class ComparisonForm
  include ActiveModel::Model

  attr_accessor :items, :comparison

  delegate :comparands, :errors, :item1, :item2, :result, to: :comparison

  def initialize(options = {})
    @comparison = Comparison.new
    @items = options.fetch(:items) { get_items }
    build_comparands
    self.winning_item_id = options[:winning_item_id]
  end

  def winning_item_id=(id)
    comparison.winning_item = Item.find_by_id(id)
  end

  def winning_item_id
    comparison.winning_item.id if comparison.winning_item
  end

  def save
    if comparison.save
      update_ratings!(item1, item2, result)
    else
      false
    end
  end

  def submit_title
    ["Vote", "Go", "Do it", "Engage", "Make it so", "Make judgement"].sample
  end

  def submitting_title
    ["Voting", "Going", "Doing it", "Engaging", "Making it so"].sample
  end

  def neutral_title
    ["No preference", "Hard to say", "Meh", "Dunno", "idk", "w/e"].sample
  end

  private

  def update_ratings!(item1, item2, result)
    item1_rating, item2_rating = EloRating.updated_ratings(item1.rating, item2.rating, result)
    item1.update!(rating: item1_rating)
    item2.update!(rating: item2_rating)
  end

  def build_comparands
    items.each do |item|
      comparison.comparands.build(item_id: item.id)
    end
  end

  def get_items
    [Item.find(1), Item.find(2)]
  end
end
