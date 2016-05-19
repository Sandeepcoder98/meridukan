class AddColumnApplyForApprovalToProduct < ActiveRecord::Migration
  def change
  	add_column :products,:apply_approve,:boolean,default: :false
  end
end
