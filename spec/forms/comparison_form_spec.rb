require 'spec_helper'

describe ComparisonForm do
  describe '.new' do
    it 'is created with 2 items' do
      item1 = Item.new
      comparison_form = ComparisonForm.new(item1: item1)
      expect(comparison_form.item1).to eql item1
    end
  end

  describe '#save' do
    it 'saves the comparison' do
      item1 = Item.create(name: "foo")
      item2 = Item.create(name: "bar")
      comparison_form = ComparisonForm.new(item1: item1, item2: item2)
      expect(comparison_form.comparison).to receive(:save)
      comparison_form.save
    end

    context 'valid comparison' do
      it 'updates the ratings of the items' do
        item1 = Item.create(name: "foo")
        item2 = Item.create(name: "bar")
        comparison_form = ComparisonForm.new(item1: item1, item2: item2, result: 0)
        expect(item1).to receive(:update!)
        expect(item2).to receive(:update!)
        comparison_form.save
      end

      it 'returns true' do
        item1 = Item.create(name: "foo")
        item2 = Item.create(name: "bar")
        comparison_form = ComparisonForm.new(item1: item1, item2: item2, result: 0)
        expect(comparison_form.save).to be_truthy
      end
    end

    context 'invalid comparison' do
      it 'returns false' do
        item1 = Item.create(name: "foo")
        item2 = Item.create(name: "bar")
        comparison_form = ComparisonForm.new(item1: item1, item2: item2)
        expect(comparison_form.save).to be_falsey
      end
    end
  end
end
