class EloRating
  attr_reader :k_factor
  def initialize(k_factor: 24)
    @k_factor = k_factor
  end

  def self.updated_ratings(a_rating, b_rating, result)
    new.updated_ratings(a_rating, b_rating, result)
  end

  def updated_ratings(a_rating, b_rating, result)
    a_actual_score = a_score(result)
    a_expected_score = EloRating.expected_score(a_rating, b_rating)
    a_updated_rating = updated_rating(a_rating, a_expected_score, a_actual_score)
    b_updated_rating = updated_rating(b_rating, 1 - a_expected_score, 1 - a_actual_score)
    return a_updated_rating, b_updated_rating
  end

  def self.expected_score(player_rating, opponent_rating)
    1.0/(1 + (10 ** ((opponent_rating - player_rating)/400.0)))
  end

  private

  def a_score(result)
    {
      0 => 0.5, # draw
      1 => 1,   # a wins
      2 => 0    # b wins
    }[result]
  end

  def updated_rating(rating, expected_score, actual_score)
    (rating + k_factor * (actual_score - expected_score)).to_i
  end
end
