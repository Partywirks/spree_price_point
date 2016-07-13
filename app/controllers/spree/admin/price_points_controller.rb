module Spree
  module Admin
    class PricePointsController < Spree::Admin::BaseController
      def destroy
        @price_point = Spree::PricePoint.find(params[:id])
        @price_point.destroy
        render nothing: true
      end
    end
  end
end
