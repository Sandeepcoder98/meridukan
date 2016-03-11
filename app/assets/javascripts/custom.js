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

  // Custom css of search index page 
   $(function() {
    var availableTags = [
      "ActionScript",
      "AppleScript",
      "Asp",
      "BASIC",
      "C",
      "C++",
      "Clojure",
      "COBOL",
      "ColdFusion",
      "Erlang",
      "Fortran",
      "Groovy",
      "Haskell",
      "Java",
      "JavaScript",
      "Lisp",
      "Perl",
      "PHP",
      "Python",
      "Ruby",
      "Scala",
      "Scheme"
    ];
    $( "#tags" ).autocomplete({
      source: availableTags
    });
  });
  // Starrr plugin (https://github.com/dobtco/starrr)
  var __slice = [].slice;

  (function($, window) {
    var Starrr;

    Starrr = (function() {
      Starrr.prototype.defaults = {
        rating: void 0,
        numStars: 5,
        change: function(e, value) {}
      };

      function Starrr($el, options) {
        var i, _, _ref,
          _this = this;

        this.options = $.extend({}, this.defaults, options);
        this.$el = $el;
        _ref = this.defaults;
        for (i in _ref) {
          _ = _ref[i];
          if (this.$el.data(i) != null) {
            this.options[i] = this.$el.data(i);
          }
        }
        this.createStars();
        this.syncRating();
        this.$el.on('mouseover.starrr', 'span', function(e) {
          return _this.syncRating(_this.$el.find('span').index(e.currentTarget) + 1);
        });
        this.$el.on('mouseout.starrr', function() {
          return _this.syncRating();
        });
        this.$el.on('click.starrr', 'span', function(e) {
          return _this.setRating(_this.$el.find('span').index(e.currentTarget) + 1);
        });
        this.$el.on('starrr:change', this.options.change);
      }

      Starrr.prototype.createStars = function() {
        var _i, _ref, _results;

        _results = [];
        for (_i = 1, _ref = this.options.numStars; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--) {
          _results.push(this.$el.append("<span class='glyphicon .glyphicon-star-empty'></span>"));
        }
        return _results;
      };

      Starrr.prototype.setRating = function(rating) {
        if (this.options.rating === rating) {
          rating = void 0;
        }
        this.options.rating = rating;
        this.syncRating();
        return this.$el.trigger('starrr:change', rating);
      };

      Starrr.prototype.syncRating = function(rating) {
        var i, _i, _j, _ref;

        rating || (rating = this.options.rating);
        if (rating) {
          for (i = _i = 0, _ref = rating - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
            this.$el.find('span').eq(i).removeClass('glyphicon-star-empty').addClass('glyphicon-star');
          }
        }
        if (rating && rating < 5) {
          for (i = _j = rating; rating <= 4 ? _j <= 4 : _j >= 4; i = rating <= 4 ? ++_j : --_j) {
            this.$el.find('span').eq(i).removeClass('glyphicon-star').addClass('glyphicon-star-empty');
          }
        }
        if (!rating) {
          return this.$el.find('span').removeClass('glyphicon-star').addClass('glyphicon-star-empty');
        }
      };

      return Starrr;

    })();
    return $.fn.extend({
      starrr: function() {
        var args, option;

        option = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return this.each(function() {
          var data;

          data = $(this).data('star-rating');
          if (!data) {
            $(this).data('star-rating', (data = new Starrr($(this), option)));
          }
          if (typeof option === 'string') {
            return data[option].apply(data, args);
          }
        });
      }
    });
  })(window.jQuery, window);

  $(function() {
    return $(".starrr").starrr();
  });

  $( document ).ready(function() {
        $('[data-toggle="tooltip"]').tooltip({'placement': 'top'});
    $('#stars').on('starrr:change', function(e, value){
      $('#count').html(value);
    });
    
    $('#stars-existing').on('starrr:change', function(e, value){
      $('#count-existing').html(value);
    });
  });
  $(function(){
      var sampleTags = ['c++', 'java', 'php', 'coldfusion', 'javascript', 'asp', 'ruby', 'python', 'c', 'scala', 'groovy', 'haskell', 'perl', 'erlang', 'apl', 'cobol', 'go', 'lua'];

     
      $('#singleFieldTags2').tagit({
          availableTags: sampleTags
      }); 

  });

  $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
      event.preventDefault();
      $(this).ekkoLightbox({
        'fadeDuration': 200,
        'wrapAround': true
      });
  });
  $(document).ready(function() {
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("tab-active-btn").addClass("tab-unactive-btn");
        // $(".tab").addClass("active"); // instead of this do the below 
        $(this).removeClass("tab-unactive-btn").addClass("tab-active-btn");   
    });
  });
  $(document).ready(function(e){
      $('.search-panel .dropdown-menu').find('a').click(function(e) {
      e.preventDefault();
      var param = $(this).attr("href").replace("#","");
      var concept = $(this).text();
      $('.search-panel span#search_concept').text(concept);
      $('.input-group #search_param').val(param);
    });
  });
  $(function () {
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


       
    });
    
    $('body').tooltip({
        selector: '[data-toggle]',
        position: 'top'
    });

    $('body').on('click','.search-main-actions', function(){
      $(this).closest("form").attr("action", $(this).attr("data-url"))
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

$(document).ready(function(){
  if (typeof CKEDITOR != 'undefined'){
      var preview = CKEDITOR.document.getById( 'preview' );

    function syncPreview() {
        preview.setHtml( editor.getData() );
    }

    var editor = CKEDITOR.replace( 'editor', {
        on: {
            // Synchronize the preview on user action that changes the content.
            change: syncPreview,
            
            // Synchronize the preview when the new data is set.
            contentDom: syncPreview
        }
    } );
  }
})

