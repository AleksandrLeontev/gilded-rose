require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  let(:helmets) { [
    { name: 'Golden Helmet', sell_in: 10, quality: 90 },
  ] }


  let(:roses) { [
    { name: '+5 Dexterity Vest', sell_in: 10, quality: 20 },
    { name: '+5 Dexterity Vest', sell_in: 10, quality: 0 },
    { name: '+5 Dexterity Vest', sell_in: 10, quality: 64 },
  ] }

  let(:aged_roses) {
    [
      { name: 'Aged Brie', sell_in: 0, quality: 10 }
    ]
  }

  let(:backstage_roses) {
    [
      { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 15, quality: 20 },
      { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 10, quality: 40 },
      { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: 5, quality: 40 },
      { name: 'Backstage passes to a TAFKAL80ETC concert', sell_in: -5, quality: 40 },
    ]
  }

  let(:conjured_roses) {
    [
      { name: 'Conjured Mana Cake', sell_in: 3, quality: 6 },
      { name: 'Conjured Mana Cake', sell_in: 0, quality: 6 },
    ]
  }

  let(:sulfuras_roses) {
    [
      { name: 'Sulfuras, Hand of Ragnaros', sell_in: 10, quality: 80 },
    ]
  }

  describe 'GoldenHelmet#update_quality' do

    before :each do
      @gilded_roses = GildedRose.new(helmets)
      @gilded_roses.update_quality
    end

    it 'should not be more than 80' do
      expect(@gilded_roses.items[0].quality).to eq 80
    end

  end


  describe 'RoseItem#update_quality' do

    before :each do
      @gilded_roses = GildedRose.new(roses)
      @gilded_roses.update_quality
    end

    it 'does not change the name' do
      expect(@gilded_roses.items[0].name).to eq '+5 Dexterity Vest'
    end

    it 'should reduce sell in count' do
      expect(@gilded_roses.items[0].sell_in).to eq 9
    end

    it 'should reduce quality' do
      expect(@gilded_roses.items[0].quality).to eq 19
    end

    it 'quality should not be less than zero(0)' do
      expect(@gilded_roses.items[1].quality).to eq 0
    end

    it 'quality should not be more than 50' do
      expect(@gilded_roses.items[2].quality).to eq 50
    end

  end

  describe 'AgedBrieRose#update_quality' do

    before :each do
      @gilded_roses = GildedRose.new(aged_roses)
      @gilded_roses.update_quality
    end

    it 'should add double quality with negative sell_in value' do
      expect(@gilded_roses.items[0].quality).to eq 12
    end

  end

  describe 'BackstagePassRose#update_quality' do

    before :each do
      @gilded_roses = GildedRose.new(backstage_roses)
      @gilded_roses.update_quality
    end

    it 'should increase quality to 2 for sell_in value less than 11' do
      expect(@gilded_roses.items[1].quality).to eq 42
    end

    it 'should increase quality to 3 for sell_in value less than 6' do
      expect(@gilded_roses.items[2].quality).to eq 43
    end

    it 'should set quality to value 3 for sell_in value less than 0' do
      expect(@gilded_roses.items[3].quality).to eq 3
    end

  end


  describe 'ConjuredRose#update_quality' do

    before :each do
      @gilded_roses = GildedRose.new(conjured_roses)
      @gilded_roses.update_quality
    end

    it 'should do a double reduction in quality with positive sell_in value' do
      expect(@gilded_roses.items[0].quality).to eq 4
    end

    it 'should reduce quality by four times with negative sell_in value' do
      expect(@gilded_roses.items[1].quality).to eq 2
    end

  end

  describe 'SulfurasRose#update_quality' do

    before :each do
      @gilded_roses = GildedRose.new(sulfuras_roses)
      @gilded_roses.update_quality
    end

    it 'should not change sell_in' do
      expect(@gilded_roses.items[0].sell_in).to eq 10
    end

    it 'should not change quality' do
      expect(@gilded_roses.items[0].quality).to eq 80
    end

  end

end
