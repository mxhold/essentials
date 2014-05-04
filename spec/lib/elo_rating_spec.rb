require_relative '../../lib/elo_rating.rb'

describe EloRating do
  describe '.updated_ratings' do
    before do
      @a_rating = 2000
      @b_rating = 1900
      @elo_rating = EloRating.new { 10 }
    end

    describe 'returns the updated scores for two players given their ratings and the result of a match' do
      it 'winning' do
        a_updated, b_updated = @elo_rating.updated_ratings(@a_rating, @b_rating, 1)
        expect(a_updated).to eq 2003
        expect(b_updated).to eq 1896
      end

      it 'losing' do
        a_updated, b_updated = @elo_rating.updated_ratings(@a_rating, @b_rating, 2)
        expect(a_updated).to eq 1993
        expect(b_updated).to eq 1906
      end

      it 'draw' do
        a_updated, b_updated = @elo_rating.updated_ratings(@a_rating, @b_rating, 0)
        expect(a_updated).to eq 1998
        expect(b_updated).to eq 1901
      end
    end
  end

  describe '.expected_score' do
    it 'returns the probability of winning given a player\'s Elo rating and their opponent\'s rating' do
      expect(EloRating.expected_score(1613, 1388)).to be_within(0.001).of(0.785)
    end
  end
end
