class EloRating
  def initialize(&k_factor)
    if k_factor
      @k_factor = k_factor
    else
      @k_factor = Proc.new do |rating|
        if rating < 2100
          32
        elsif 2100 <= rating && rating <= 2400
          24
        elsif 2400 < rating
          16
        end
      end
    end
  end

  def self.updated_ratings(a_rating, b_rating, result)
    new.updated_ratings(a_rating, b_rating, result)
  end

  def updated_ratings(a_rating, b_rating, result)
    case result
    when 0 # draw
      a_score, b_score = 0.5, 0.5
    when 1 # a wins
      a_score, b_score = 1, 0
    when 2 # b wins
      a_score, b_score = 0, 1
    end
    a_updated = updated_rating(a_rating, EloRating.expected_score(a_rating, b_rating), a_score)
    b_updated = updated_rating(b_rating, EloRating.expected_score(b_rating, a_rating), b_score)
    return a_updated, b_updated
  end

  def self.expected_score(player_rating, opponent_rating)
    1.0/(1 + (10 ** ((opponent_rating - player_rating)/400.0)))
  end

  private

  def k_factor(rating)
    @k_factor.call(rating)
  end

  def updated_rating(rating, expected_score, actual_score)
    (rating + k_factor(rating) * (actual_score - expected_score)).to_i
  end
end
