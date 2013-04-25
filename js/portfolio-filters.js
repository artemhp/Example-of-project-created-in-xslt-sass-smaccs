jQuery.fn.extend({
	/* author: Artem Deykun */
    porfolio_filter: function (item) {
		$('#portfolio-filters li').click(function() {
			var filtered = new Array();
  			var category = $(this).parent('ul').parent('div').attr('class');
  			var value = $(this).children('.select').text();

			$('#portfolio_filters_info').show();
			$('#portfolio_filters_info').html("Filtered by <span class='portfolio_filters_info_category'>" + category + "</span>: <span class='portfolio_filters_info_value'>" + value);

			var position = $('#portfolio_filters_info').offset();
			$('html, body').animate({scrollTop: $('#portfolio_filters_info').offset().top}, 500);


  			$('.portfolio').find('.'+category+' li').each(function(){
  				if($(this).text() == value){
					filtered.push($(this).parents('.item').attr('id'));
  				}
  			});
  			$('.portfolio .item').each(function(){
				if ($.inArray(this.id, filtered) < 0) {
					$(this).removeClass('is-shown');
					$(this).addClass('is-hidden');
				} else {
					$(this).removeClass('is-hidden');
					$(this).addClass('is-shown');
				}
  			});
		});
    }
});