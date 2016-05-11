class SellerDocumentsController < ApplicationController
	# before action need to check the method
  before_action :add_seller_document, only: [:create, :update]


	def create;end

	def update;end


private
	
	def seller_documents_params
		params.require(:seller_document).permit(:business_name,:business_type,:pan_card_number,:vat_card_number,:tan_card_number,:account_name,:account_number,:bank_name,:state,:city,:bank_branch,:ifsc_code,:address_proof,:pan_card,:vat_card,:tan_card,:upload_address_proof,:cancelled_cheque)
	end

	def add_seller_document
		current_user.seller_document ? current_user.seller_document.update(seller_documents_params) : current_user.build_seller_document(seller_documents_params).save
		redirect_to :back
	end

end