class AddApproveFieldsToSellerDocument < ActiveRecord::Migration
  def change
  	add_column :seller_documents,:bank_details_approve,:boolean,default: :false
  	add_column :seller_documents,:business_details_approve,:boolean,default: :false
  end
end
