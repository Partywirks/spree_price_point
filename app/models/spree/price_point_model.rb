class Spree::PricePointModel < ActiveRecord::Base
  has_many :variants
  has_many :price_points, -> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :price_points, allow_destroy: true,
    reject_if: proc { |price_point|
      price_point[:offset].blank? 
    }
end
