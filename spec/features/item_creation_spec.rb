require 'spec_helper'

feature 'Item creation' do
  scenario 'User creates an item' do
    visit new_item_path

    fill_in :item_name, with: 'Grand piano'

    click_button 'Create Item'
    expect(Item.count).to eql 1
    expect(page).to have_content 'successfully created'
  end
end
