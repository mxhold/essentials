class ComparisonForm
  include ActiveModel::Model

  attr_accessor :comparison

  delegate :errors, :item1, :item2, :result, to: :comparison

  def initialize(comparison_params = nil)
    comparison_params ||= new_comparison_params
    self.comparison = Comparison.new(comparison_params)
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

  def new_comparison_params
    items = get_items
    {
      item1: items.first,
      item2: items.last
    }
  end

  def update_ratings!(item1, item2, result)
    item1_rating, item2_rating = EloRating.updated_ratings(item1.rating, item2.rating, result)
    item1.update!(rating: item1_rating)
    item2.update!(rating: item2_rating)
  end

  def get_items
    Item.find(Item.pluck(:id).sample(2))
  end
end
