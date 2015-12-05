class CreateSpreePricePointModels < ActiveRecord::Migration
  def change
    create_table :spree_price_point_models do |t|
    #, :id => false do |t|
     # t.uuid :id, :primary_key => true, default: "uuid_generate_v4()"
      t.string :name
      t.timestamps null: false
    end

    create_table :spree_price_point_models_variants do |t|
    #, :id => false do |t|
     # t.uuid :id, :primary_key => true, default: "uuid_generate_v4()"
      t.belongs_to :price_point_model
      t.belongs_to :variant
      # t.uuid :price_point_model_id
      # t.uuid :variant_id

    end

    #comment this out if using UUIDs
    add_reference :spree_price_points, :price_point_model

    add_index :spree_price_point_models_variants, :price_point_model_id, name: 'price_point_model_id'
    add_index :spree_price_point_models_variants, :variant_id, name: 'variant_id'
  end
end
