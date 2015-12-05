Spree::Order.class_eval do

	def find_line_item_by_variant(variant, options = {})
    line_items.detect { |line_item|
                  line_item.variant_id == variant.id &&
                  line_item_options_match(line_item, options)
                }
  end

  def line_item_options_match(line_item, options)
      return true unless options

      unless options[:price_point_id].blank?
      	return line_item.price_point_id.to_s == options[:price_point_id].to_s
      end

      self.line_item_comparison_hooks.all? { |hook|
        self.send(hook, line_item, options)
      }
    end

end
