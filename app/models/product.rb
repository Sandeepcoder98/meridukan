class Product < ActiveRecord::Base
  acts_as_taggable
  has_many :galleries
  has_one :product_shipping_detail  
  has_one :pricing
  has_one :additional_offer
  belongs_to :category
  belongs_to :sub_category
  belongs_to :child_sub_category, class_name: "SubCategory"
  belongs_to :store
  has_one :product_offer
  has_one :price_offer
  # has_one :product_offer, :through => :additional_offer, :source => :offer, :source_type => "ProductOffer"
  # has_one :price_offer, :through => :additional_offer, :source => :offer, :source_type => "PriceOffer"
  accepts_nested_attributes_for :galleries, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :product_shipping_detail
  accepts_nested_attributes_for :pricing
  accepts_nested_attributes_for :additional_offer
  accepts_nested_attributes_for :product_offer, :reject_if => :all_blank
  accepts_nested_attributes_for :price_offer, :reject_if => :all_blank
  acts_as_taggable_on :name

  validates :title,:description,:delivery_time,:category_id,:galleries,:presence=>true

  # Setting Up Objects  
  searchable do
    integer :id
    integer :store_id
    text :title
    join(:city, :target => Store, :type => :text, :join => { :from => :id, :to => :store_id })
    join(:state, :target => Store, :type => :text, :join => { :from => :id, :to => :store_id })
    join(:landmark, :target => Store, :type => :text, :join => { :from => :id, :to => :store_id })
    join(:address, :target => Store, :type => :text, :join => { :from => :id, :to => :store_id })
    join(:pin_code, :target => Store, :type => :text, :join => { :from => :id, :to => :store_id })
    latlon(:location) { 
      Sunspot::Util::Coordinates.new(store.lat, store.lng)
    }
    string :tags, :multiple => true do
      tags.collect(&:name)
    end
    float :pricing do
      pricing.mrp_per_unit
    end
    # join(:mrp_per_unit, :target => Pricing, :type => :float, :join => { :from => :product_id, :to => :id })
    text :category do
      category.title
    end
    text :sub_category do
      sub_category.title
    end
    text :child_sub_category do
      child_sub_category.title
    end
  end

  def net_mrp
    net_mrp = pricing.mrp_per_unit.to_f-pricing.offer_on_mrp.to_f rescue 0
    (net_mrp>0 ? net_mrp : 0).round(2) 
  end

  def offer_type
    additional_offer.offer_type
  end

  def offer
    send additional_offer.offer_type rescue nil
  end

  def photo_url
    galleries.last.photo.url rescue ""
  end
end


