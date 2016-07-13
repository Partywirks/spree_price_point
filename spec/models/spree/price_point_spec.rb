RSpec.describe Spree::PricePoint, type: :model do
  it { is_expected.to belong_to(:variant) }
  # it { is_expected.to validate_presence_of(:variant) }
  it { is_expected.to validate_presence_of(:offset) }

  before do
    @price_point = Spree::PricePoint.new(variant: Spree::Variant.new, offset: -1)
  end

end
