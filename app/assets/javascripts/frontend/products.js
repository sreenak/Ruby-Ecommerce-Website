

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

     $('.add-to-cart-size').on('click',function () {
        var size = $('#standard_size_id').val();
        if(size=='') {

                $('#dis').slideDown().html('<span id="size-error">Please Choose Your Size</span>');
                $('#standard_size_id').css('border-color','red');
                return false;
          
        }
        return true;
    });
/*


     $('.add-to-cart-size').on('click',function(){
         var size = $('standard_size_id').val();
        console.log(size); 
     })*/

    $('#standard_size_id').append('<option value="10">Custom size</option>');

    $(document).on('change','#standard_size_id',function(){
            var optionValue = $(this).find('option:selected').val();
            if(optionValue=='10'){
                $('.shop_selection_size').show();
            }else{
                $('.shop_selection_size').hide();
            }
    });

    $(document).on('click','#shop_form_submit',function(){

        var optionValue = $('#standard_size_id').find('option:selected').val();
        console.log(typeof optionValue,optionValue)
        if(optionValue=='10'){

            var emptyInput=[];
            $('#shop_fields input.form-control').each(function(i, obj) {
                if($(this).val().trim()==''){
                    emptyInput.push('yes');
                }
            });
            console.log(emptyInput);
            if(emptyInput.length>0){
               // alert('Please fill all the custom sizes fields ');
                generalErrorpopup('Custom sizing Error','Please fill all the custom size fields');
                return;
            }else{
                $('#shop_form').submit();
            }
        }else{
            $('#shop_form').submit();
        }
    });
    $( "#shop_fields input.form-control" ).keypress(function(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    });
   // $('#shop_form').submit();

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
    function generalErrorpopup(headertext,bodytext){
       $('#popup_model_error_header h4').text(headertext);
       $('#popup_model_error_text p').text(bodytext);
       $('#alertpopups').trigger('click');
    }


});