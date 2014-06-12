require 'spec_helper'

feature 'Comparison creation' do
  scenario 'User creates a comparison and it\'s a draw' do
    item1 = Item.create!(id: 1, name: "Foo")
    item2 = Item.create!(id: 2, name: "Bar")
    visit new_comparison_path

    within '.comparison_choices' do
      choose('comparison_result_1')
    end

    find('[type=submit]').click
    expect(page).to have_content 'successfully created'
    expect(item1.rating).to eql 1000
    expect(item2.rating).to eql 1000
  end

  scenario 'User creates a comparison with a winner' do
    item1 = Item.create!(id: 1, name: "Foo")
    item2 = Item.create!(id: 2, name: "Bar")
    visit new_comparison_path

    within '.comparison_choices' do
      choose('Foo')
    end

    find('[type=submit]').click
    expect(page).to have_content 'successfully created'
    expect(item1.reload.rating).to eql 1016
    expect(item2.reload.rating).to eql 984
  end
end
