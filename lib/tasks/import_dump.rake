namespace :import_dump do
  desc "TODO"
  task app: :environment do
  	(1..50).each do |number|
	  	user = User.create({  
		   "email"   =>"seller#{number}@gmail.com",
		   "mobile"   =>887100000+number,
		   "first_name"   =>"Seller #{number}",
		   "last_name"   =>"Seller #{number}",
		   "address"   =>"AB Rd, Near Malhar Mall, Vijay Nagar #{number}",
		   "city"   =>"Indore",
		   "country"   =>nil,
		   "state"   =>"Madhya Pradesh",
		   "phone"   =>8085600000+number,
		   "pin_code"   =>452010,
		   "lat"   =>22.7+(number/100),
		   "lng"   =>75.8+(number/100),
		   "password" => "12345678"
		})

		user.add_user_role("seller")  
		store = user.build_store({  
		   "name"=>"Test Store #{number}",
		   "address"=>"Near Nawlakha #{number}",
		   "state"=>"Madhya Pradesh",
		   "city"=>"Indore",
		   "pin_code"=>452001,
		   "landmark"=>"Relince store ",
		   "lat"  =>22.6+(number/100),
		   "lng"  =>75.4+(number/100)
		})

		user.save

	
		puts "User ##{number} created" 
		puts "Store ##{number} created"
		
		(1..100).each do |number_product|
			product = store.products.new({
				"title"=>"Test Product #{number_product}",
				"description"=>"Test Product Description #{number_product}",
				"delivery_time"=>1,
				"category_id"=>3,
				"sub_category_id"=>114,
				"child_sub_category_id"=>116,
				"approve"=>false,
				"status"=>true,
				"step_path"=>"publish"
			})
			product.build_pricing({
				"stock_quantity"=>10,
				"mrp_per_unit"=>983.0,
				"offer_on_mrp"=>100.0
			})
			product.build_product_shipping_detail({
				"free_delivery"=>true,
				"free_kilometers"=>500,
				"charge_per_kilometer"=>10.0
			})
			product.build_price_offer({
				"percent"=>"10.0",
				"amount"=>"8000.0",
				"gift"=>"You will get free watch #{number_product}",
				"choice_type"=>2
			})
			product.build_additional_offer({
				"offer_type"=>"price_offer"
			})
			if(number_product%2==0)
			product.galleries.new({
				"photo"=> open("http://www.grazia.fr/var/grazia/storage/images/media/images/beaute/fruits-et-legumes-bons-pour-la-peau/la-papaye-l-hydratation/13024300-1-fre-FR/La-papaye-l-hydratation_exact780x585_l.jpg")
			})
			elsif(number_product%3==0)
			product.galleries.new({
				"photo"=> open("http://www.spainbymikerandolph.com/wp-content/uploads/2012/10/fruit1.jpg")
			})
			else
			product.galleries.new({
				"photo"=> open("http://thumbs.dreamstime.com/z/fruit-market-24373697.jpg")
			})
			end

			product.tag_list = "test#{number_product}, test#{number_product+1}, test#{number_product+2}, test#{number_product+3}"
			product.save
			puts "        Product ##{number_product} created" 
		end
	end

  end

end