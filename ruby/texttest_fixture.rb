#!/usr/bin/ruby -w

require 'awesome_print'
require File.join(File.dirname(__FILE__), 'gilded_rose')

puts 'Start test!'

items = [
    RoseItem.new('+5 Dexterity Vest', 10, 20),
    RoseItem.new('Aged Brie', 2, 0),
    RoseItem.new('Elixir of the Mongoose', 5, 7),
    RoseItem.new('Sulfuras, Hand of Ragnaros', 0, 80),
    RoseItem.new('Sulfuras, Hand of Ragnaros', -1, 80),
    RoseItem.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
    RoseItem.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
    RoseItem.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
    # This Conjured item does not work properly yet
    RoseItem.new('Conjured Mana Cake', 3, 6), # <-- :O
]

days = 2
days = ARGV[0].to_i + 1 if ARGV.size.positive?

gilded_rose = GildedRose.new items
(0...days).each do |day|
  puts "-------- day #{day} --------".green
  puts 'name, sellIn, quality'.yellow
  items.each { |item| puts item.to_s.blue }
  puts ''
  gilded_rose.update_quality
end
