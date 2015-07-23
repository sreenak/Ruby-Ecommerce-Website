$(window).load(function(){
    $('.sp-wrap').smoothproducts();
});

$(function(){
	$("#gift").click(function(){

        $(".send-gift-to").css('display','none');
		if($(this).prop('checked'))
		{
			
			$(".send-gift-to").css('display','block');
		}

	})
})