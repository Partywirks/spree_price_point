Spree::PermittedAttributes.class_eval do

	# @@line_item_attributes = [:id, :quantity, :price, :variant_id, :price_point_id]

	# @@line_item_attributes = [:id, :variant_id, :quantity, :price_point_id]

	# @@checkout_attributes = [ :coupon_code, :email, :shipping_method_id, :special_instructions, :use_billing, :price_point_id ]

  # @@checkout_attributes.push(:price_point_id)

  # class_variable_set('@@checkout_attributes', [ :coupon_code, :email, :shipping_method_id, :special_instructions, :use_billing, :price_point_id])

  class_variable_set('@@line_item_attributes', [ :id, :variant_id, :quantity, :price_point_id ])

end