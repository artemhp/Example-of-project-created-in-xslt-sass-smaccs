jQuery.fn.extend({
	/* author: Artem Deykun */
    porfolio_view: function (list) {
    	var viewer = this;
	    $(list).find('.item').each(function() {
		  $(this).click(function() {
		  	$(viewer).addClass('is-shown');
		  	var portfolioID = this.getAttribute("data-screenshot");
		  	$(viewer).find(".img").html("<img src='./img/portfolio/"+portfolioID+".png' />");
	  		  var position = $(viewer).offset();
			  if ($(document).scrollTop() > position.top) {
				$('html, body').animate({scrollTop: $(viewer).offset().top}, 1000);
			  }
		  });
		});
    }
});