Spree::BaseHelper.class_eval do
  def display_price_point(variant, price_point_id)
    Spree::Money.new(variant.price_point(price_point_id), { currency: Spree::Config[:currency] }).to_html
  end
end
