class Spree::PricePoint < ActiveRecord::Base
  belongs_to :variant, touch: true
  belongs_to :price_point_model, touch: true
  # belongs_to :spree_role, class_name: "Spree::Role", foreign_key: "role_id"
  acts_as_list scope: [:variant_id, :price_point_model_id]

  validates :offset, presence: true
  # validates :name, presence: true

end
