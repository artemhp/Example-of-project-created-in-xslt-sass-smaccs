jQuery.fn.extend({
	/* author: Artem Deykun */
	fixing_navigation: function () {   
		var navigation = this;
		var position = $(navigation).offset();

		var navigation_position = function() {
			if (position.top) {
				if ($(document).scrollTop() < position.top) {
					$(navigation).removeClass('is-fixed');
				} else {
					$(navigation).addClass('is-fixed');			
				}
			}
		}		
		navigation_position ();

		$(window).scroll(function () {    
			navigation_position();
		});
	}
});