class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items.map { |item| GildedRose.wrap(item) }
  end

  def update_quality
    items.each(&:update)
  end

  def self.wrap(params)
    case params[:name]
    when "Golden Helmet"
      GoldenHelmet.new(params)
    when "Aged Brie"
      AgedBrieRose.new(params)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassRose.new(params)
    when "Conjured Mana Cake"
      ConjuredRose.new(params)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasRose.new(params)
    else
      RoseItem.new(params)
    end
  end

end

class RoseItem
  attr_accessor :name, :sell_in, :quality

  def initialize(params)
    @name = params.fetch(:name, "Standard Rose")
    @sell_in = params.fetch(:sell_in, 0)
    @quality = params.fetch(:quality, 0)
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    sell
    update_quality
  end

  def sell
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
    @quality = new_quality
  end

  def to_s
    "name: #{@name}, sellIn: #{@sell_in}, quality: #{@quality}"
  end
end

class GoldenHelmet < RoseItem

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 80 if new_quality > 80
    @quality = new_quality
  end

end

class AgedBrieRose < RoseItem
  def calculate_quality_adjustment
    adjustment = 1
    adjustment += 1 if sell_in < 0
    adjustment
  end
end

class BackstagePassRose < RoseItem
  def calculate_quality_adjustment
    adjustment = 1
    adjustment += 1 if sell_in < 11
    adjustment += 1 if sell_in < 6
    adjustment -= quality if sell_in < 0
    adjustment
  end
end

class ConjuredRose < RoseItem
  def calculate_quality_adjustment
    adjustment = -2
    adjustment -= 2 if sell_in < 0
    adjustment
  end
end

class SulfurasRose < RoseItem
  def calculate_quality_adjustment
    # This item don't change anything
  end
end