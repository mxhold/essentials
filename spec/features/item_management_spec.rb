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

feature 'Item editing' do
  scenario 'User edits an item' do
    Item.create(name: 'Grand piano')
    visit items_path
    within '#items' do
      click_link 'Edit'
    end

    fill_in :item_name, with: 'Player piano'
    click_button 'Update Item'

    expect(Item.last.name).to eql 'Player piano'
  end
end

feature 'Item removal' do
  scenario 'User destroys an item' do
    Item.create(name: 'Grand piano')
    visit items_path
    within '#items' do
      click_link 'Destroy'
    end
    
    expect(Item.count).to eql 0
  end
end
