class AddPricePointIdToLineItems < ActiveRecord::Migration
  def change
  	add_column :spree_line_items, :price_point_id, :integer #:uuid
  end
end
