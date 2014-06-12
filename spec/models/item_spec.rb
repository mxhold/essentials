require 'spec_helper'

describe Item do
  describe 'validations' do
    it 'is valid given a name' do
      item = Item.new(name: 'Bed')
      expect(item.valid?).to be_truthy
    end
    it 'is invalid without a name' do
      item = Item.new
      expect(item.valid?).to be_falsey
    end
  end

  describe '#to_s' do
    it 'returns the item name' do
      item = Item.new(name: 'Piano')
      expect(item.to_s).to eql 'Piano'
    end
  end
end
