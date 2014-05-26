require 'spec_helper'

describe Comparison do
  describe 'validations' do
    it 'is valid with 2 items and a result in range' do
      comparison = Comparison.new
      comparison.build_item1
      comparison.build_item2
      comparison.result = 1
      expect(comparison.valid?).to be_truthy
    end

    it 'is invalid without 2 items' do
      comparison = Comparison.new
      comparison.build_item1
      comparison.valid?
      expect(comparison.errors).to have_key(:item2)
    end

    it 'is invalid without a result in range' do
      comparison = Comparison.new
      comparison.result = 3
      comparison.valid?
      expect(comparison.errors).to have_key(:result)
    end

    it 'is invalid with 2 of the same items' do
      comparison = Comparison.new
      item1 = Item.new
      comparison.item1 = item1
      comparison.item2 = item1
      comparison.valid?
      expect(comparison.errors.full_messages.to_sentence).to match "must be different"
    end
  end

  describe '#draw?' do
    it 'returns true if there is no winner' do
      comparison = Comparison.new
      comparison.winning_item = nil
      expect(comparison.draw?).to be_truthy
    end

    it 'returns false if there is a winner' do
      comparison = Comparison.new
      item1 = comparison.build_item1
      comparison.winning_item = item1
      expect(comparison.draw?).to be_falsey
    end
  end

  describe '#winning_item=' do
    it 'sets the winning item to nil given nil' do
      comparison = Comparison.new
      comparison.winning_item = nil
      expect(comparison.winning_item).to be_nil
    end

    it 'sets the winning item given an item' do
      comparison = Comparison.new
      item = comparison.build_item1
      comparison.winning_item = item
      expect(comparison.winning_item).to eql item
    end
  end
end
