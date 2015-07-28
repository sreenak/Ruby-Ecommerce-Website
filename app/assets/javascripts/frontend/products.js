function getQueryParams(qs) {
    qs = qs.split('+').join(' ');
    var params = {},
        tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;
    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
    }
    return params;
}
$(window).load(function () {
    $('.sp-wrap').smoothproducts();
    $('#gift').click(function () {
        $('.send-gift-to').toggleClass('hidden');
    });
    var price = getQueryParams(document.location.search).price;
    $("#price-range").slider({from: 0, to: 10000, heterogeneity: ['10/1000'], step: 100, dimension: '₹&nbsp;'});
    if(price){
        var priceComponents = price.split(';');
        var from = priceComponents[0];
        var to = priceComponents[1];
        $("#price-range").slider('value', from, to)
    }
    $(".sort-by-product").click(function () {
        $('.sort-by-list').toggleClass('hidden');
    });
});