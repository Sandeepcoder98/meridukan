// Search Products and Shops

// Global Variables
window.SearchPage = 1 
window.IsActive = false

// Ready function that ready dom elements
$(document).ready(function(){
  // html safe text callback using handlebars
  Handlebars.registerHelper('raw', function(description) {
    return new Handlebars.SafeString(description);
  });

  $("#search_button").click(function(){
   $(this).closest("form").submit()
  });

  $("#search_it_now").click(function(){
   $(this).closest("form").submit()
  });

  $("#search_selection li a").click(function(){
  	action = $(this).attr("data-action")
    $("#search_text").attr("placeholder",$(this).attr("data-text"))
  	$(this).closest("form").attr("action",action)
  });

  // Searching products when page load or scrolled
  // If condition is check that it is products search page or not
  if ($("[data-object=search_products]").length>0){
    FindLatLongAndSearchProducts();
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
        SearchProductHit
      else
        $(this).data('timer', setTimeout(SearchProductHit, 500));
  });


  // Searching stores when page load or scrolled
  // If condition is check that it is stores search page or not
  if ($("[data-object=search_stores]").length>0){
    FindLatLongAndSearchStores();
    $(window).scroll(function(){
      if($(window).scrollTop()+1200 > $(document).height() - $(window).height())
      {  
        SearchStores();
      }
    });
  }

  // Filtering products and call SearchHit
  $('body').on("keyup change", "[data-store-query]",function(e){    
      clearTimeout($.data(this, 'timer'));
      if (e.keyCode == 13)
        SearchStoreHit
      else
        $(this).data('timer', setTimeout(SearchStoreHit, 500));
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
var SearchProductHit = function() {
    $("[data-object=search_products]").html("")
    $('div#loadmoreajaxloader').html("<center><img src=\"/assets/loader.gif\" /></center>").show()
    window.IsActive = false;
    window.SearchPage = 1;
    SearchProducts();
}

// Getting lat long from end user side
var FindLatLongAndSearchProducts = function(){
  if (readCookie("latitude") && readCookie("longitude")){
    $(".current_lat").val(readCookie("latitude"))
    $(".current_lng").val(readCookie("longitude"))
    SearchProducts();
  }
  else{
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function (p) {
        var LatLng = new google.maps.LatLng(p.coords.latitude, p.coords.longitude);
        createCookie("latitude",p.coords.latitude,7) 
        createCookie("longitude",p.coords.longitude,7) 
        $(".current_lat").val(readCookie("latitude"))
        $(".current_lng").val(readCookie("longitude"))
        SearchProducts();
      }, function(){
        $.getJSON( "//freegeoip.net/json/", function( data ) {
          createCookie("latitude",data.latitude,7) 
          createCookie("longitude",data.longitude,7) 
          $(".current_lat").val(readCookie("latitude"))
          $(".current_lng").val(readCookie("longitude"))
          SearchProducts();
        });
      });
    } else {
        alert('Geo Location feature is not supported in this browser.');
    }
  }
}


// building search query for the stores
var BuildStoresSearchQuery = function (){
  query= {}
  $("[data-store-query]").each(function(){
    attr = $(this).attr("data-store-query")
    val = $(this).val()
    query[attr] = val
  })
  return query;
}

// Search Stores function
var SearchStores = function(){
  if (!window.IsActive){
    window.IsActive = true;
    query = BuildStoresSearchQuery()
    $('div#loadmoreajaxloader').show();
    $.ajax({
      url: "/search/find_stores.json?page="+window.SearchPage,
      async: true,
      data: query,
      success: function(data)
      { 
        if(data.length>0)
        {
          $(data).each(function(){
            var source   = $("#search-stores").html();
            var template = Handlebars.compile(source);
            $("[data-object=search_stores]").append(template(this))
            $(".starrr").starrr();
            // modal_effects()
          })
          window.SearchPage = window.SearchPage+1
          $('div#loadmoreajaxloader').hide();
          window.IsActive = false;
        }else
        {
            $('div#loadmoreajaxloader').html('<center>No more stores to show.</center>');
        }
      }
    });
  }
}

// Function for filtering the store
var SearchStoreHit = function() {
    $("[data-object=search_stores]").html("")
    $('div#loadmoreajaxloader').html("<center><img src=\"/assets/loader.gif\" /></center>").show()
    window.IsActive = false;
    window.SearchPage = 1;
    SearchStores();
}

// Getting lat long from end user side
var FindLatLongAndSearchStores =function(){
  if (readCookie("latitude") && readCookie("longitude")){
    $(".current_lat").val(readCookie("latitude"))
    $(".current_lng").val(readCookie("longitude"))
    SearchStores();
  }
  else{
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function (p) {
        var LatLng = new google.maps.LatLng(p.coords.latitude, p.coords.longitude);
        createCookie("latitude",p.coords.latitude,7) 
        createCookie("longitude",p.coords.longitude,7) 
        $(".current_lat").val(readCookie("latitude"))
        $(".current_lng").val(readCookie("longitude"))
        SearchStores();
      }, function(){
        $.getJSON( "//freegeoip.net/json/", function( data ) {
          createCookie("latitude",data.latitude,7) 
          createCookie("longitude",data.longitude,7) 
          $(".current_lat").val(readCookie("latitude"))
          $(".current_lng").val(readCookie("longitude"))
          SearchStores();
        });
      });
    } else {
        alert('Geo Location feature is not supported in this browser.');
    }
  }
}