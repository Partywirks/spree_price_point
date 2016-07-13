class CreateSpreePricePoints < ActiveRecord::Migration
  def change
    create_table :spree_price_points do |t|
    # , :id => false do |t|
    #   t.uuid :id, :primary_key => true, default: "uuid_generate_v4()"
      t.references :variant
      #t.uuid :variant_id
      #t.uuid :price_point_model_id
      t.string :name
      t.decimal :offset, precision: 8, scale: 2
      t.integer :position
      t.timestamps null: false

    end
  end
end
