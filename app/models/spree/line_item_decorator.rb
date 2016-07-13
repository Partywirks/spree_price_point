Spree::LineItem.class_eval do

  # Assumption here is that the price point currency is the same as the product currency
  # also, assumption here is that no other modules will want to patch the copy_price method (like spree_volume_pricing)
  old_copy_price = instance_method(:copy_price)
  define_method(:copy_price) do
   
    # old_copy_price::
    # if variant
    #   update_price if price.nil?
    #   self.cost_price = variant.cost_price if cost_price.nil?
    #   self.currency = variant.currency if currency.nil?
    # end
    old_copy_price.bind(self).call

    if variant
      unless self.price_point_id.blank?
        self.price = self.variant.price_point(self.price_point_id, self.quantity, self.order.user)
      end

      if self.price.nil?
        self.price = self.variant.price
      end
    end
  end

end
