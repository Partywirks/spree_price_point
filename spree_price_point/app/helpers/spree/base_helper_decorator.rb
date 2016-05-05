Spree::BaseHelper.class_eval do
  def display_price_point(variant, price_point_id, qty=1, user=nil)
    Spree::Money.new(variant.price_point(price_point_id, qty, user), { currency: Spree::Config[:currency] }).to_html
  end
end
