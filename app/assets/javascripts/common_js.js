	function initializeGmap() {
		var geocoder = new google.maps.Geocoder();
		google.maps.event.addDomListener(document, 'ready', initialize(geocoder)); 
	}
	$(document).ready(function(){
		$("#pricing").on("click", function() { 
			form_data = new FormData();
				form_data.append('pricing[stock_quantity]', $('#stock_quantity').val());
				form_data.append('pricing[mrp_per_unit]', $('#mrp_per_unit').val());
				form_data.append('pricing[offer_on_mrp]', $('#offer_on_mrp').val());
				form_data.append('pricing[product_id]', $('#product_id').val());
				$.ajax({
				url:  "/pricings/get_pricing", 
				type: "POST",
				processData: false,
				contentType: false,
				data: form_data,
					success: function(data) {
						 if(data.hasOwnProperty('errors')){
								$("#notice").html(data["errors"])         
							}
							else{
								calculate_offer($('#mrp_per_unit').val(),$('#offer_on_mrp').val()/100)	
								$("#notice").html("")
								$("#notice").html(data["notice"])      
							}                    
					}
			});
		});
		$("#mrp_per_unit,#offer_on_mrp").on('change',function(){
				var mrp = $("#mrp_per_unit").val()
				var offer_price = $("#offer_on_mrp").val() 
				if((mrp>0) && (offer_price>0)){		    	
					calculate_offer(mrp,offer_price)		    	
				}
				else
				{
					alert("Invalid Offer price or MRP")
				}    
			})
		
		var calculate_offer = function (mrp,offer_price) {
			$("#net_mrp").val(mrp-(mrp *(offer_price/100)))
		}

		$("#mrp_per_unit,#offer_on_mrp").on('change',function(){
				var mrp = $("#mrp_per_unit").val()
				var offer_price = $("#offer_on_mrp").val() 
				if((mrp>0) && (offer_price>0)){		    	
					calculate_offer(mrp,offer_price)		    	
				}
				else
				{
					alert("Invalid Offer price or MRP")
				}    
			}) 
		$("#bg_cover").on('click',function(){
			$(".bg_cover_field").trigger('click')
		})
});

function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
            $('#bg_cover img')
              .attr('src', e.target.result)
              .width(248)
              .height(291);
          };

          reader.readAsDataURL(input.files[0]);
        }
      }	