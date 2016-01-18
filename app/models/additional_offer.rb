class AdditionalOffer < ActiveRecord::Base
	belongs_to :product
	belongs_to :offer, :polymorphic=>true	
end
