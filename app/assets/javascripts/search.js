// Search Products and Shops

// Global Variables
window.SearchPage = 1 
window.IsActive = false

// Ready function that ready dom elements
$(document).ready(function(){
  $("#search_button").click(function(){
   $(this).closest("form").submit()
  });

  $("#search_it_now").click(function(){
   $(this).closest("form").submit()
  });

  $("#search_selection li a").click(function(){
  	action = $(this).attr("data-action")
  	$(this).closest("form").attr("action",action)
  });

  // Searching products when page load or scrolled
  // If condition is check that it is products search page or not
  if ($("[data-object=search_products]").length>0){
    SearchProducts();
    $(window).scroll(function(){
      if($(window).scrollTop()+1200 > $(document).height() - $(window).height())
      {  
        SearchProducts();
      }
    });
  }

  // Filtering products and call SearchHit
  $('body').on("keyup change", "[data-product-query]",function(e){    
      clearTimeout($.data(this, 'timer'));
      if (e.keyCode == 13)
        SearchHit
      else
        $(this).data('timer', setTimeout(SearchHit, 500));
  });
});

// building search query for the products
var BuildProductsSearchQuery = function (){
  query= {}
  $("[data-product-query]").each(function(){
    attr = $(this).attr("data-product-query")
    val = $(this).val()
    if(attr=="pricing"){
      query[attr] = []
      $("[data-product-query='pricing']").each(function (){
        if($(this).prop("checked")){
          query[attr].push(this.value)
        }
      })
    }else{
      query[attr] = val
    }
  })
  return query;
}

// Search Products function
var SearchProducts = function(){
  if (!window.IsActive){
    window.IsActive = true;
    query = BuildProductsSearchQuery()
    $('div#loadmoreajaxloader').show();
    $.ajax({
      url: "/search/products.json?page="+window.SearchPage,
      async: true,
      data: query,
      success: function(data)
      { 
        if(data.length>0)
        {
          $(data).each(function(){
            var source   = $("#search-products").html();
            var template = Handlebars.compile(source);
            $("[data-object=search_products]").append(template(this))
            $(".starrr").starrr();
            // modal_effects()
          })
          window.SearchPage = window.SearchPage+1
          $('div#loadmoreajaxloader').hide();
          window.IsActive = false;
        }else
        {
            $('div#loadmoreajaxloader').html('<center>No more products to show.</center>');
        }
      }
    });
  }
}

// Function for filtering the product
var SearchHit = function() {
    $("[data-object=search_products]").html("")
    $('div#loadmoreajaxloader').html("<center><img src=\"/assets/loader.gif\" /></center>").show()
    window.IsActive = false;
    window.SearchPage = 1;
    SearchProducts();
}