require 'delegate'

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each do |item|
      RoseItemWrapper.wrap(item).update
    end
  end

end

class RoseItemWrapper < SimpleDelegator
  def self.wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrieRose.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassRose.new(item)
    when "Conjured Mana Cake"
      ConjuredRose.new(item)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasRose.new(item)
    else
      new(item)
    end
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    age
    update_quality
  end

  def age
    self.sell_in -= 1
  end

  def update_quality
    self.quality += calculate_quality_adjustment
  end

  def calculate_quality_adjustment
    adjustment = 0
    adjustment -= 1
    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class AgedBrieRose < RoseItemWrapper
  def calculate_quality_adjustment
    adjustment = 1
    adjustment += 1 if sell_in < 0
    adjustment
  end
end

class BackstagePassRose < RoseItemWrapper
  def calculate_quality_adjustment
    adjustment = 1
    adjustment += 1 if sell_in < 11
    adjustment += 1 if sell_in < 6
    adjustment -= quality if sell_in < 0
    adjustment
  end
end

class ConjuredRose < RoseItemWrapper
  def calculate_quality_adjustment
    adjustment = -2
    adjustment -= 2 if sell_in < 0
    adjustment
  end
end

class SulfurasRose < RoseItemWrapper
  def calculate_quality_adjustment
    #This item don't change anything
  end
end

class RoseItem
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
