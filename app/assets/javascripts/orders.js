
$(document).ready(function(){
  $("body").on("click", "[data-popup-modal]", function(e){
    var that = this
    var data;
    product_id = $(that).attr("data-product-id")
    $.ajax({
      async: true,
      url: "/orders/view_product",
      method: "get",
      data: {product_id: product_id},
      success: function(data){
        source   = $("#view-product").html();
        template = Handlebars.compile(source);
        $("#view-porduct-holder").html(template(data))
        id = $(that).attr("data-popup-modal")
        $("#"+id).hide().addClass("md-show").css("overflow-y", "scroll").show()
        $("html").css("overflow-y","hidden")
        $("#view-porduct-holder .starrr").starrr();
        $(".product-slide").bootstrapNews({
            newsPerPage: 4,
            autoplay: true,
            pauseOnHover:true,
            direction: 'up',
            newsTickerInterval: 5000,
            onToDo: function () {
                //console.log(this);
            }
        });
        $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
         ProductView() //slider js for product image sliding
      }
    })

    e.preventDefault()
  })

  $("body").on("click", ".md-close", function(){
    $this = $(this).closest(".md-show")
    $this.removeClass("md-show").css("overflow-y", "hidden")
    $("html").css("overflow-y","scroll")
  })

})


// Add product to cart
var productAddToCart = function(e){
  $.ajax({
    url: "/orders/add_to_card",
    method: "post",
    success: function(data){
      $this = $("#modal-12")
      $this.removeClass("md-show").css("overflow-y", "hidden")
      $("html").css("overflow-y","scroll")
    },
    failure: function(){

    }
  })
}