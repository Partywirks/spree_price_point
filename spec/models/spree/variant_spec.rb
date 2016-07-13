RSpec.describe Spree::Variant, type: :model do
  it { is_expected.to have_many(:price_points) }

  describe '#price_point' do

    context 'offset price point' do
      before :each do
        #19.99 is default factory price
        @product = create :product, variants: 3.times.map { create(:variant) }
        # @product.variants.map { |v| v.stock_items.first.update_column(:count_on_hand, 10) }
        @variant = @product.variants.first
      end

      it 'uses the master variant price point' do
        @price_point = create :price_point, offset: -3, name: 'Child'
        @product.master.price_points << @price_point

        expect(@variant.product.master.price_points.first.offset.to_f).to be(-3.0)
      end

      it 'can associate price point models' do
        price_point_model = create(:price_point_model, name: 'test')
        price_point_model.price_points << create(:price_point, offset: -5, name: 'Child')
        @product.master.price_point_models << price_point_model
        expect(@product.master.price_point_models.first.price_points.first.offset.to_f).to be(-5.00)
      end

    end

  end
end
