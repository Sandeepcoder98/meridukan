function initializeGmap() {
	var geocoder = new google.maps.Geocoder();
	google.maps.event.addDomListener(document, 'ready', initialize(geocoder)); 
}
$(document).ready(function(){

	
	
	

	$("#bg_cover").on('click',function(){
		$(".bg_cover_field").trigger('click')
	})

	$("#product_sub_category_id").chained("#product_category_id");
  	$("#product_child_sub_category_id").chained("#product_sub_category_id");
  	
  	$("#offer_type").on("change",function(){
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