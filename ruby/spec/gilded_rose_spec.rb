require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "Sulfuras" do
      it "sell in value doesn't change" do
        sulfuras = [Item.new("Sulfuras, Hand of Ragnaros", 3, 80)]
        expect(sulfuras[0].sell_in).to eq 3
      end

      context "sell in > 0" do
        it "doesn't change in quality" do
          sulfuras = [Item.new("Sulfuras, Hand of Ragnaros", 3, 80)]
          GildedRose.new(sulfuras).update_quality()
          expect(sulfuras[0].quality).to eq 80
        end
      end

      context "sell in < 0" do
        it "doesn't change in quality" do
          sulfuras = [Item.new("Sulfuras, Hand of Ragnaros", -3, 80)]
          GildedRose.new(sulfuras).update_quality()
          expect(sulfuras[0].quality).to eq 80
        end
      end
    end

    context "Aged Brie" do

      it "doesn't increase quality when quality is 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        gilded_rose=GildedRose.new(items)
        expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 0
      end

      context "sell in > 0" do
        it "quality goes up by one" do
          items = [Item.new("Aged Brie", 10, 30)]
          gilded_rose=GildedRose.new(items)
          expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 1
        end
      end

      context "sell in < 0" do
        it "quality goes up by two" do
          items = [Item.new("Aged Brie", -10, 30)]
          gilded_rose=GildedRose.new(items)
          expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 2
        end
      end
    end

    context "Backstage passes" do

      it "doesn't increase quality when quality is 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
        gilded_rose=GildedRose.new(items)
        expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 0
      end

      context "sell in > 0" do
        it "quality goes up by one if sells in > 12" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 30)]
          gilded_rose=GildedRose.new(items)
          expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 1
        end

        it "quality goes up by two if sells in between 6 and 11 days" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 30)]
          gilded_rose=GildedRose.new(items)
          expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 2
        end

        it "quality goes up by three if sells in under 6 days" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 30)]
          gilded_rose=GildedRose.new(items)
          expect{gilded_rose.update_quality()}.to change{items[0].quality}.by 3
        end
      end

      context "sell in < 0" do
        it "quality equals zero if past sell in date" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -2, 30)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 0
        end
      end
    end

    context "Other items" do
      it "quality goes down by one" do
        items = [Item.new("foo", 10, 30)]
        gilded_rose=GildedRose.new(items)
        expect{gilded_rose.update_quality()}.to change{items[0].quality}.by -1
      end
    end
  end
end