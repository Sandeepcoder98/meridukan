// Search Products

$(document).ready(function(){
  $("#search_button").click(function(){
   $(this).closest("form").submit()
  });

  $("#search_selection li a").click(function(){
  	action = $(this).attr("data-action")
  	$(this).closest("form").attr("action",action)
  });

  if ($("[data-object=search_products]").length>0){
    search_objects = JSON.parse($("[data-object=search_products]").attr("data-items"))
    $(search_objects).each(function(){
      $("[data-object=search_products]").append(search_products_template(this))
    })

    var page = 2;

    $(window).scroll(function(){
      if($(window).scrollTop()+700 > $(document).height() - $(window).height())
      {
        q = $("[data-object=search_products]").attr("data-q")
        $('div#loadmoreajaxloader').show();
        
        $.ajax({
          url: "/search.json?q="+q+"&page="+page,
          async: false,
          success: function(data)
          { 
              if(data.length>0)
              {
                $(data).each(function(){
                  $("[data-object=search_products]").append(search_products_template(this))
                })
                page = page+1
                $('div#loadmoreajaxloader').hide();
              }else
              {
                  $('div#loadmoreajaxloader').html('<center>No more posts to show.</center>');
              }
          }
        });
      }
    });
  }

  if ($("[data-object=search_stores]").length>0){
    search_objects = JSON.parse($("[data-object=search_stores]").attr("data-items"))
    $(search_objects).each(function(){
      $("[data-object=search_stores]").append(search_stores_template(this))
    })

    var page = 2;

    $(window).scroll(function(){
      if($(window).scrollTop()+700 > $(document).height() - $(window).height())
      {
        q = $("[data-object=search_stores]").attr("data-q")
        $('div#loadmoreajaxloader').show();
        
        $.ajax({
          url: "/search/stores.json?q="+q+"&page="+page,
          async: false,
          success: function(data)
          { 
              if(data.length>0)
              {
                $(data).each(function(){
                  $("[data-object=search_stores]").append(search_stores_template(this))
                })
                page = page+1
                $('div#loadmoreajaxloader').hide();
              }else
              {
                  $('div#loadmoreajaxloader').html('<center>No more posts to show.</center>');
              }
          }
        });
      }
    });
  }
 });

var search_products_template = function(data){
  return "<div class=\"col-md-3\"><div class=\"advance-box\"> <img src=\""+data.photo_url+"\" width=\"274\" height=\"182\"><div class=\"color-box1\"> <a href=\"/products/"+data.id+"\">"+data.title+"</a><input type=\"text\" class=\"btn btn-danger\" value=\"Buy It\"/><br></div></div><br></div>"
};


var search_stores_template = function(data){
  return "<div class=\"col-md-3\"><div class=\"advance-box\"> <img src=\"http://png.clipart.me/previews/3b6/small-store-icon-psd-45819.jpg\" width=\"274\" height=\"182\"><div class=\"color-box1\"> <a href=\"\">"+data.name+"</a><input type=\"text\" class=\"btn btn-danger\" value=\"Visit Store\"/><br></div></div><br></div>"
};
