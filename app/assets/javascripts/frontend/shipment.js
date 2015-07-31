$(window).load(function(){

    $('.ordered-img-wrap img').each(function(){
     var ht = $(this).height();
      $(".prd-desc, .prd-dtl, .orderd-price-wrap").css('min-height',ht)
    })

    $('#approve,.approving-status').hover(function(){
    	$('.approving-status').toggleClass('hidden')
    })
    $('#process,.processing-status').hover(function(){
    	$('.processing-status').toggleClass('hidden')
    })
    $('#shipping,.shipping-status').hover(function(){
    	$('.shipping-status').toggleClass('hidden')
    })
    $('#delivery,.delivery-status').hover(function(){
    	$('.delivery-status').toggleClass('hidden')
    })
})