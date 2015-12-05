RSpec.describe Spree::LineItem, type: :model do
  before do    
    #19.99 is default factory price
    @product = create :product, variants: 3.times.map { create(:variant) }
    @variant = @product.variants.first
    @price_point = create(:price_point, offset: -4, name: 'Adult')
    @product.master.price_points << @price_point
    
  end

  it 'make sure the line items records the price_point_id' do
    @order = create(:order)
    #def add(variant, quantity = 1, options = {})
    @order.contents.add(@variant, 1, { price_point_id: @price_point.id })
    @order.contents.add(@variant)
    expect(@order.line_items.first.price_point_id).to be(@price_point.id)
  end


  it 'make sure the line items has correct price point' do
    @order = create(:order)
    #def add(variant, quantity = 1, options = {})
    @order.contents.add(@variant, 1, { price_point_id: @price_point.id })
    expect(@order.line_items.first.price.to_f).to be(15.99)
  end

end
