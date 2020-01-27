require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  let(:roses) { [
      RoseItem.new('+5 Dexterity Vest', 10, 20),
      RoseItem.new('+5 Dexterity Vest', 10, 0),
      RoseItem.new('+5 Dexterity Vest', 10, 64),
  ] }

  describe 'RoseItem#update_quality' do

    it 'does not change the name' do
      GildedRose.new(roses).update_quality
      expect(roses.first.name).to eq '+5 Dexterity Vest'
    end

    it 'should reduce sell in count' do
      GildedRose.new(roses).update_quality
      expect(roses.first.sell_in).to eq 9
    end

    it 'should reduce quality' do
      GildedRose.new(roses).update_quality
      expect(roses.first.quality).to eq 19
    end

    it 'quality should not be less than zero(0)' do
      GildedRose.new(roses).update_quality
      expect(roses[1].quality).to eq 0
    end

    it 'quality should not be more than 50' do
      GildedRose.new(roses).update_quality
      expect(roses[2].quality).to eq 50
    end

  end

  #describe 'RoseItem#update_quality' do
  #
  #  it 'does not change the name' do
  #    GildedRose.new(items).update_quality
  #    expect(items.first.name).to eq '+5 Dexterity Vest'
  #  end
  #
  #  it 'should reduce sell in count' do
  #    GildedRose.new(items).update_quality
  #    expect(items.first.sell_in).to eq 9
  #  end
  #
  #  it 'should reduce quality' do
  #    GildedRose.new(items).update_quality
  #    expect(items.first.quality).to eq 19
  #  end
  #
  #end

end
