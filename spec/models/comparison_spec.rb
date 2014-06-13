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

    it 'is invalid without a result between 0 and 2' do
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
    it 'returns true if the result is 0' do
      comparison = Comparison.new
      comparison.result = 0
      expect(comparison.draw?).to be_truthy
    end

    it 'returns false if the result is not 0' do
      comparison = Comparison.new
      comparison.result = 1
      expect(comparison.draw?).to be_falsey
    end
  end

  describe '#winning_item' do
    it 'returns nil if the result is 0' do
      comparison = Comparison.new(result: 0)
      expect(comparison.winning_item).to be_nil
    end

    it 'returns item1 if the result is 1' do
      item = Item.new(name: 'Piano')
      comparison = Comparison.new(item1: item, result: 1)
      expect(comparison.winning_item).to eql item
    end

    it 'returns item2 if the result is 2' do
      item = Item.new(name: 'Piano')
      comparison = Comparison.new(item2: item, result: 2)
      expect(comparison.winning_item).to eql item
    end
  end
end
