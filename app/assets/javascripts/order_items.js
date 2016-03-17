
$(document).ready(function(){
  $("body").on("click", "[data-popup-modal]", function(e){
    var that = this
    var data;
    product_id = $(that).attr("data-product-id")
    $.ajax({
      async: true,
      url: "/products/"+product_id+"/view_product",
      method: "get",
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

  $(".cart-table .remove-item").click(function(e){
    order_item_id = $(this).attr("data-order-item-id")
    $(this).closest("tr").remove()
    $.ajax({
      url: "/order_items/"+order_item_id,
      method: "delete"
    })
    e.preventDefault()
  });

  $("body").on("keyup",".change-qty",function(e){
    var regexp1=new RegExp("[^0-9]");
    if(!$(this).val() || regexp1.test($(this).val()))
    {
      $(this).val(1)
    }
    changeItemQuantity(this)
  })

  $("body").on("keyup",".check-number",function(e){
    var regexp1=new RegExp("[^0-9]");
    if(!$(this).val() || regexp1.test($(this).val()))
    {
      $(this).val(1)
    }
  })
})


// Add product to cart
var productAddToCart = function(e){
  $that = $(e).closest(".add-to-cart").find("#qty")
  quantity = $that.val()
  product_id = $(e).attr("data-product-id")
  if ($that.val() && parseInt($that.val()) > 0){
    $.ajax({
      url: "/order_items/quick_add",
      method: "post",
      data: {order_item: {product_id: product_id, quantity: quantity}}
    })
  }
  else
  {
    $that.css("border", "1px solid #FF0B0B")
    setTimeout(function(){ $that.css("border","") }, 200);
  }
}


// Add product to cart
var oneProductAddToCart = function(e){
  product_id = $(e).attr("data-product-id")
    $.ajax({
      url: "/order_items",
      method: "post",
      data: {order_item: {product_id: product_id, quantity: "1"}}
    })
}


var hideQuickViewPopup = function(e){
  $this = $("#modal-12")
  if ($this.length<1)
    window.location.href = "/"
  $this.removeClass("md-show").css("overflow-y", "hidden")
  $("html").css("overflow-y","scroll")
}

// Add product to cart
var changeItemQuantity = function(e){
    $this = $(e).parent("td").find(".change-qty")
    quantity = $this.val()
    product_id = $this.attr("data-product-id")
    id = $this.attr("data-id")
    $.ajax({
      url: "/order_items/"+id,
      method: "put",
      data: {order_item: {product_id: product_id, quantity: quantity}}
    })
}
