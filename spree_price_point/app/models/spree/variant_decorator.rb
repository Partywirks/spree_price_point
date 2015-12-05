Spree::Variant.class_eval do
  has_and_belongs_to_many :price_point_models
  has_many :price_points, -> { order(position: :asc) }, dependent: :destroy
  has_many :model_price_points,-> { order(position: :asc) }, class_name: "Spree::PricePoint", through: :price_point_models, source: :price_points
  accepts_nested_attributes_for :price_points, allow_destroy: true,
    reject_if: proc { |price_point|
      price_point[:offset].blank?
    }

  def join_price_points
    price_point_table = Spree::PricePoint.arel_table
    Spree::PricePoint.where(price_point_table[:variant_id].eq(self.id).or(price_point_table[:price_point_model_id].in(self.price_point_models.ids))).order(position: :asc)
  end

  def price_point(price_point_id='')

    if self.product.master.join_price_points.count == 0
      return self.price
    else
      self.product.master.join_price_points.each do |price_point|
        if price_point.id == price_point_id
          offset_price = self.price + price_point.offset 
          if offset_price < 0
            offset_price = 0
          end
          return offset_price
        end
      end
      # still no price points...
      return self.price
    end
  end

end
