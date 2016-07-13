Spree::Order.class_eval do

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
