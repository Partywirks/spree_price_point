RSpec.describe Spree::BaseHelper, type: :helper do
  include Spree::BaseHelper

  context 'price point' do
    before do
      #19.99 is default factory price
      @product = create :product, variants: 3.times.map { create(:variant) }
      # @product.variants.map { |v| v.stock_items.first.update_column(:count_on_hand, 10) }
      @price_point = create :price_point, offset: -1, name: 'Child'
      @product.master.price_points << @price_point
      @variant = @product.variants.first
    end

    it 'shows correct amount without price point' do
      expect(display_price_point(@variant, nil)).to eq '$19.99'
    end

    it 'shows correct price point amount' do
      expect(display_price_point(@variant, @price_point.id)).to eq '$18.99'
    end

  end
end
