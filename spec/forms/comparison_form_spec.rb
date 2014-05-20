require 'spec_helper'

describe ComparisonForm do
  describe '#save' do
    it 'saves the comparison' do
      comparison_form = ComparisonForm.new(items: [])
      comparison = double("comparison")
      comparison_form.comparison = comparison

      expect(comparison).to receive(:save)
      comparison_form.save
    end

    it 'updates the items ratings if the comparison is valid' do
      item1 = object_double(Item.new, rating: 1, id: 1)
      item2 = object_double(Item.new, rating: 2, id: 2)
      comparison_form = ComparisonForm.new(items: [item1, item2])
      comparison = double("comparison")
      allow(comparison).to receive(:save).and_return(true)
      comparison_form.comparison = comparison
      result = 0
      comparison.result = result

      expect(comparison_form).to receive(:update_ratings!).with(item1, item2, result)
      comparison_form.save
    end
  end

end
