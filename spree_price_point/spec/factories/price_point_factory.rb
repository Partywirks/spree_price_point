FactoryGirl.define do
  factory :price_point, class: Spree::PricePoint do
    offset -1
    name "test pp"
    association :variant
  end

  factory :price_point_model, class: Spree::PricePointModel do
    name "test model"
  end
end
