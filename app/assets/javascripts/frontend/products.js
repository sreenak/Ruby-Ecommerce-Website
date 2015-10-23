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
    $("#zoom_03").elevateZoom({
        gallery: 'gallery_01',
        cursor: 'pointer',
        galleryActiveClass: 'active',
        imageCrossfade: true,
        loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif'
    });
    //pass the images to Fancybox
    $("#zoom_03").bind("click", function (e) {
        var ez = $('#zoom_03').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });

//    $('.sp-wrap').smoothproducts();
    /*===============massege box toggle ===========*/
    $('#gift').click(function () {
        $('.send-gift-to').toggleClass('hidden');
    });

    /*=============== price slider =================*/
    if (typeof max_price != 'undefined') {
        var price = getQueryParams(document.location.search).price;
        $("#price-range").slider({
            from: 0,
            to: max_price,
            heterogeneity: ['10/1000'],
            step: max_price / 10,
            dimension: '&nbsp;'
        });
        if (price) {
            var priceComponents = price.split(';');
            var from = priceComponents[0];
            var to = priceComponents[1];
            $("#price-range").slider('value', from, to)
        }
    }

    /*=============== sortby ============*/
    $(".user-log").click(function () {
        $('.sort-by-list').toggleClass('hidden');
    });

    /*============= Clear Filters ===========*/

    $(".clear-filters").click(function () {
        var clear_filter = $(this).parent().next('ul');
        $(clear_filter).children('li').children('label').children('input').prop('checked', false)
    });

    $('.add-to-cart-size').click(function () {
        var size = $('input[name=standard_size_id]').val();
        //alert(size);
        //alert($('input[name=standard_size_id]:checked').length);
        if (size != undefined) {
            if ($('input[name=standard_size_id]:checked').length == 0) {
                $('#dis').slideDown().html('<span id="size-error">Please choose Size</span>');
                return false;
            }
        }
        return true;
    });

    $('#Size').append('<option value="10">Custom size</option>');

    $(document).on('change','#Size',function(){
            var optionValue = $(this).find('option:selected').val();
            if(optionValue=='10'){
                $('.shop_selection_size').show();
            }else{
                $('.shop_selection_size').hide();
            }
    });

//on click search
//    $(".product-categories input[type=checkbox]").click(function(){
//        this.form.submit();
//    });
//    $(".product-size input[type=checkbox]").click(function(){
//        this.form.submit();
//    });
//    $(".product-price-flt").click(function(){
//        $("#product_search").submit();
//    });


});