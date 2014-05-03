# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
items = [
  "Bed",
  "Snowboard",
  "Printer",
  "Speakers",
  "Headphones",
  "KitchenAid mixer",
  "Old MacBook Pro",
  "MacBook Pro",
  "Broken desktop computer",
  "Toothbrush",
 ]

 items.each do |item_name|
   Item.create!(name: item_name)
 end
