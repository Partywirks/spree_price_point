module Spree
  module Admin
    class PricePointModelsController < ResourceController

      before_action :load_price_points, only: [:new, :edit]
      respond_to :json, only: [:get_children]

      def get_children
        @price_points = PricePoint.find(params[:parent_id]).children
      end

      private

      def location_after_save
        if @price_point_model.created_at == @price_point_model.updated_at
          edit_admin_price_point_model_url(@price_point_model)
        else
          admin_price_point_models_url
        end
      end

      def load_price_points
        @price_point_model.price_points.build if @price_point_model.price_points.empty?
      end
    end
  end
end
