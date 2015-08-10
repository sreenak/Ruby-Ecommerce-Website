$(window).load(function(){

    $('.ordered-img-wrap img').each(function(){
     var ht = $(this).height();
      $(".prd-desc, .prd-dtl, .orderd-price-wrap").css('min-height',ht)
    })

    $('#approve,.approving-status').hover(function(){
    	$('#approve i').toggleClass('hover')
    	$('.approving-status').toggleClass('hidden')
    })
    $('#process,.processing-status').hover(function(){
    	$('#process i').toggleClass('hover')
    	$('.processing-status').toggleClass('hidden')
    })
    $('#shipping,.shipping-status').hover(function(){
    	$('#shipping i').toggleClass('hover')
    	$('.shipping-status').toggleClass('hidden')
    })
    $('#delivery,.delivery-status').hover(function(){
    	$('#delivery i').toggleClass('hover')
    	$('.delivery-status').toggleClass('hidden')
    })
})
