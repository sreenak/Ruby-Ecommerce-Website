$(window).load(function () {
    $('.sp-wrap').smoothproducts();
});

$(function () {
    $('#gift').click(function () {
        $('.send-gift-to').toggleClass('hidden');
    })

    $("#price-rage").slider({ from: 0, to: 10000, heterogeneity: ['10/1000'], step: 100, dimension: '₹&nbsp;' });

    $(".sort-by-product").click(function(){
    	$('.sort-by-list').toggleClass('hidden');
    })
});

 