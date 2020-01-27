#!/usr/bin/ruby -w

require 'awesome_print'
require File.join(File.dirname(__FILE__), 'gilded_rose')

puts 'Start test!'

items = [
  { name: '+5 Dexterity Vest', sell_in: 10, quality: 20 },
  { name: 'Aged Brie', sell_in: 2, quality: 0 },
  { name: 'Elixir of the Mongoose', sell_in: 5, quality: 7 },
  { name: 'Sulfuras, Hand of Ragnaros', sell_in: 0, quality: 80 },
  { name: 'Sulfuras, Hand of Ragnaros', sell_in: -1, quality: 80 },
  { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 15, quality: 20 },
  { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 10, quality: 49 },
  { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 5, quality: 49 },
  # This Conjured item does not work properly yet
  { name: 'Conjured Mana Cake', sell_in: 3, quality: 6 }, # <-- :O
]

days = 2
days = ARGV[0].to_i + 1 if ARGV.size.positive?

gilded_rose = GildedRose.new items
(0...days).each do |day|
  puts "-------- day #{day} --------".green
  puts 'name, sellIn, quality'.yellow
  gilded_rose.items.each { |item| puts item.to_s.blue }
  puts ''
  gilded_rose.update_quality
end
