class Pricing < ActiveRecord::Base
  belongs_to :product
  validates :stock_quantity,:mrp_per_unit,:numericality => { :greater_than => 0}
  validates :mrp_per_unit,:stock_quantity,:presence=> true

  searchable do
    integer :product_id
    float :mrp_per_unit
  end

end
