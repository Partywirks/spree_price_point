RSpec.describe Spree::Admin::VariantsController, type: :controller do
  stub_authorization!

  context 'PUT #update' do
    it 'creates a price point' do
      variant = create :variant

      expect do
        spree_put :update,
                  product_id: variant.product.slug,
                  id: variant.id,
                  variant: {
                    'price_points_attributes' => {
                      '1335830259720' => {
                        'name' => 'test',
                        'offset' => '-1',
                        'position' => '1',
                        '_destroy' => 'false'
                      }
                    }
                  }
      end.to change(variant.price_points, :count).by(1)
    end
  end
end
