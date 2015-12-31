function initializeGmap() {
	var geocoder = new google.maps.Geocoder();
	google.maps.event.addDomListener(document, 'ready', initialize(geocoder)); 
}
$(document).ready(function(){

	$("#product_pricing_attributes_mrp_per_unit,#product_pricing_attributes_offer_on_mrp").on('keyup',function(){
			var mrp = $("#product_pricing_attributes_mrp_per_unit").val()
			var offer_price = $("#product_pricing_attributes_offer_on_mrp").val() 
			if(!offer_price){
				offer_price=0
			}
			if((mrp>0) && (offer_price=>0)){		    	
				calculate_offer(mrp,offer_price)		    	
			}
			else
			{
				alert("Invalid Offer price or MRP")
			}    
		})
	
	var calculate_offer = function (mrp,offer_price) {
		value = Math.round((mrp-offer_price) * 100) / 100
		$("#net_mrp").val(value)
	}

	$("#bg_cover").on('click',function(){
		$(".bg_cover_field").trigger('click')
	})

	$("body").on("change",".check-delivery-event", function(){
		$(".check-delivery").val("").attr("readonly",$(this).prop("checked"))
	})

	$("#product_sub_category_id").chained("#product_category_id");
  	$("#product_child_sub_category_id").chained("#product_sub_category_id");
  	
  	$("#product_additional_offer_attributes_offer_type").on("change",function(){
  		selected_value = $(this).val();
  		if(selected_value=="price_offer")	{
  			$("#price_offer").removeClass("hidden")
  			$("#product_offer").addClass("hidden")
  			return
  		}
  		else if(selected_value=="product_offer"){
  			$("#price_offer").addClass("hidden")
  			$("#product_offer").removeClass("hidden")
  			return
  		}
  		$("#product_offer").addClass("hidden")
  		$("#price_offer").addClass("hidden")
  	})
});

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#bg_cover img')
        .attr('src', e.target.result)
        .width(200);
    };

    reader.readAsDataURL(input.files[0]);
  }
}	