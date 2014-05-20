require 'spec_helper'

describe Comparison do
  describe 'validations' do
    it 'is valid with two comparands and one winner' do
      comparison = Comparison.new
      2.times { comparison.comparands.build }
      comparison.winning_comparand = comparison.comparands.first
      expect(comparison.valid?).to be_truthy
    end

    it 'is valid with two comparands and no winner' do
      comparison = Comparison.new
      2.times { comparison.comparands.build }
      expect(comparison.valid?).to be_truthy
    end

    it 'is invalid if it does not have two comparands' do
      comparison = Comparison.new
      expect(comparison.valid?).to be_falsey
    end

    it 'is invalid if its winning comparand is not one of its two comparands' do
      comparison = Comparison.new
      2.times { comparison.comparands.build }
      comparison.build_winning_comparand
      expect(comparison.valid?).to be_falsey
      expect(comparison.errors[:winning_comparand_id]).not_to be_empty
    end
  end

  describe '#draw?' do
    it 'returns true if there is no winner' do
      comparison = Comparison.new
      expect(comparison.draw?).to be_truthy
    end

    it 'returns false if there is a winner' do
      comparison = Comparison.new
      comparison.build_winning_comparand
      expect(comparison.draw?).to be_falsey
    end
  end
end
