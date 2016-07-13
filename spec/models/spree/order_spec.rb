RSpec.describe Spree::Order, type: :model do
  before do

    #19.99 is default factory price
    @product_without_price_points = create :product, variants: 3.times.map { create(:variant) }
    @product_has_price_points = create :product, variants: 3.times.map { create(:variant) }
    
    @variant_without_price_points = @product_without_price_points.variants.first

    
    @child_price_point = create(:price_point, offset: -4, position: 2, name: "Child")
    @product_has_price_points.master.price_points << @child_price_point
    @student_price_point = create(:price_point, offset: -2, position: 1, name: "Student")
    @product_has_price_points.master.price_points << @student_price_point

    @variant_with_price_points = @product_has_price_points.variants.first

    @order = create(:order)
  end

  context 'add_variant' do
    it 'uses the variant price if there are no price points' do
      @order.contents.add(@variant_without_price_points)
      expect(@order.line_items.first.price).to eq(19.99)
    end

    it 'uses the price point if specified' do
      @order.contents.add(@variant_with_price_points, 1, { price_point_id: @child_price_point.id })
      expect(@order.line_items.first.price).to eq(15.99)
    end

    it 'handles quantity correctly' do
      @order.contents.add(@variant_with_price_points, 5, { price_point_id: @child_price_point.id })
      expect(@order.total).to eq(79.95)
    end

    it 'handles adding multiple price points' do
      @order.contents.add(@variant_with_price_points, 1, { price_point_id: @student_price_point.id}) # 17.99
      @order.contents.add(@variant_with_price_points, 1, { price_point_id: @child_price_point.id }) # 15.99
      expect(@order.total).to eq(33.98) 
    end

    it 'handles quantity when adding multiple price points' do
      @order.contents.add(@variant_with_price_points, 2, { price_point_id: @student_price_point.id}) # 35.98
      @order.contents.add(@variant_with_price_points, 2, { price_point_id: @child_price_point.id }) # 31.98
      expect(@order.total.to_f).to eq(67.96) 
    end

    it 'handles adding many different price points' do
      @order.contents.add(@variant_with_price_points, 2, { price_point_id: @student_price_point.id}) # 35.98
      @order.contents.add(@variant_with_price_points, 2, { price_point_id: @student_price_point.id}) # 35.98
      expect(@order.total.to_f).to eq(71.96) 
    end

    it 'handles adding variants with and without price points' do
      @order.contents.add(@variant_with_price_points, 1) #19.99
      @order.contents.add(@variant_with_price_points, 1, { price_point_id: @child_price_point.id }) # 15.99
      expect(@order.total).to eq(35.98) 
    end

    it 'can add regular prices after price point is added' do 
      @order.contents.add(@variant_with_price_points, 2, { price_point_id: @child_price_point.id }) # 31.98
      @order.contents.add(@variant_with_price_points, 1) #19.99
      expect(@order.total).to eq(51.97) 
    end

    it 'handles recalculating price points' do
      @order.contents.add(@variant_with_price_points, 1) #19.99
      @order.contents.add(@variant_with_price_points, 1, { price_point_id: @child_price_point.id }) # 15.99
      @order.contents.add(@variant_with_price_points, 5, { price_point_id: @student_price_point.id }) # 89.95
      expect(@order.total).to eq(125.93)
    end

    it 'does not give negative prices' do
      @huge_price_point = create(:price_point, offset: -40, position: 3, name: "so huge")
      @product_has_price_points.master.price_points << @huge_price_point
      @variant_with_huge_price_point = @product_has_price_points.variants.first
      @order.contents.add(@variant_with_huge_price_point, 1, { price_point_id: @huge_price_point.id })
      expect(@order.total).to eq(0)
    end

  end
end
