require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  let(:helmet_roses) {
    [
        RoseItem.new('Golden Helmet', 10, 90)
    ]
  }

  let(:roses) { [
      RoseItem.new('+5 Dexterity Vest', 10, 20),
      RoseItem.new('+5 Dexterity Vest', 10, 0),
      RoseItem.new('+5 Dexterity Vest', 10, 64),
  ] }

  let(:aged_roses) {
    [
        RoseItem.new('Aged Brie', 0, 10)
    ]
  }

  let(:backstage_roses) {
    [
        RoseItem.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
        RoseItem.new('Backstage passes to a TAFKAL80ETC concert', 10, 40),
        RoseItem.new('Backstage passes to a TAFKAL80ETC concert', 5, 40),
        RoseItem.new('Backstage passes to a TAFKAL80ETC concert', -5, 40),
    ]
  }

  let(:conjured_roses) {
    [
        RoseItem.new('Conjured Mana Cake', 3, 6),
        RoseItem.new('Conjured Mana Cake', 0, 6),
    ]
  }

  let(:sulfuras_roses) {
    [
        RoseItem.new('Sulfuras, Hand of Ragnaros', 10, 80),
    ]
  }

  describe 'GoldenHelmet#update_quality' do

    before :each do
      GildedRose.new(helmet_roses).update_quality
    end

    it 'quality should not be more than 80' do
      expect(helmet_roses[0].quality).to eq 80
    end

  end

  describe 'RoseItem#update_quality' do

    before :each do
      GildedRose.new(roses).update_quality
    end

    it 'does not change the name' do
      expect(roses[0].name).to eq '+5 Dexterity Vest'
    end

    it 'should reduce sell in count' do
      expect(roses[0].sell_in).to eq 9
    end

    it 'should reduce quality' do
      expect(roses[0].quality).to eq 19
    end

    it 'quality should not be less than zero(0)' do
      expect(roses[1].quality).to eq 0
    end

    it 'quality should not be more than 50' do
      expect(roses[2].quality).to eq 50
    end

  end

  describe 'AgedBrieRose#update_quality' do

    before :each do
      GildedRose.new(aged_roses).update_quality
    end

    it 'should add double quality with negative sell_in value' do
      expect(aged_roses[0].quality).to eq 12
    end

  end

  describe 'BackstagePassRose#update_quality' do

    before :each do
      GildedRose.new(backstage_roses).update_quality
    end

    it 'should increase quality to 2 for sell_in value less than 11' do
      expect(backstage_roses[1].quality).to eq 42
    end

    it 'should increase quality to 3 for sell_in value less than 6' do
      expect(backstage_roses[2].quality).to eq 43
    end

    it 'should set quality to value 3 for sell_in value less than 0' do
      expect(backstage_roses[3].quality).to eq 3
    end

  end


  describe 'ConjuredRose#update_quality' do

    before :each do
      GildedRose.new(conjured_roses).update_quality
    end

    it 'should do a double reduction in quality with positive sell_in value' do
      expect(conjured_roses[0].quality).to eq 4
    end

    it 'should reduce quality by four times with negative sell_in value' do
      expect(conjured_roses[1].quality).to eq 2
    end

  end

  describe 'SulfurasRose#update_quality' do

    before :each do
      GildedRose.new(sulfuras_roses).update_quality
    end

    it 'should not change sell_in' do
      expect(sulfuras_roses[0].sell_in).to eq 10
    end

    it 'should not change quality' do
      expect(sulfuras_roses[0].quality).to eq 80
    end

  end

end
