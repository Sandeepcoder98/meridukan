class AddUploadFilesToSellerDocuments < ActiveRecord::Migration
  def change
    add_attachment :seller_documents, :pan_card
    add_attachment :seller_documents, :vat_card
    add_attachment :seller_documents, :tan_card
    add_attachment :seller_documents, :upload_address_proof
    add_attachment :seller_documents, :cancelled_cheque
  end
end
