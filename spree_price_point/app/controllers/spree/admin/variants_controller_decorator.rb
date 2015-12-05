Spree::Admin::VariantsController.class_eval do

  def edit
    @variant.price_points.build if @variant.price_points.empty?
    super
  end

  def price_points
    @product = @variant.product
    @variant.price_points.build if @variant.price_points.empty?
  end

  private

  # this loads the variant for the master variant price point editing
  def load_resource_instance
    parent

    if new_actions.include?(params[:action].to_sym)
      build_resource
    elsif params[:id]
      Spree::Variant.find(params[:id])
    end
  end

  def location_after_save
    if @product.master.id == @variant.id and params[:variant].has_key? :price_points_attributes
      return price_points_admin_product_variant_url(@product, @variant)
    end
    super
  end
end
