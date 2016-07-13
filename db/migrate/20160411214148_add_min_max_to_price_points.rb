class AddMinMaxToPricePoints < ActiveRecord::Migration
  def change
  	add_column :spree_price_points, :minimum_occupancy, :integer
  	add_column :spree_price_points, :maximum_occupancy, :integer
  	add_column :spree_price_points, :required, :boolean, :default => false
  end
end
