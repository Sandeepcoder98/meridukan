var input_image_file;

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

  $(".background-opacity").click(function(){
    that = this;
    $(".background-opacity").show()
    $(this).hide();
    target = $(this).attr("data-target")
    value = $(this).attr("data-value")
    $(".choice_type").val("")
    $("."+target+"_choice_type").val(value)
  })
});


function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    input_image_file = input;
    reader.onload = function (e) {
      class_name = $(input_image_file).parent().children(".realtime-image-show")
      $(class_name).html('<img src="'+e.target.result+'" style="width:200px;" />')
    };
    reader.readAsDataURL(input.files[0]);
  }
}	