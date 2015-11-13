$(document).ready(function () {

    $.validate({
    })

    $('.gift_card_card_type input').attr('value', 'E-GIFT CERTIFICATE');

    $('.gift-certificate.tab').click(function () {
        var target = $(this).attr('data-url');
       
        $('.gift-certificate').removeClass('active');

        $(this).addClass('active');
        var $deliveryType = $('.deliver-type');
        $deliveryType.removeClass('active');

        if (target == 'normal-gift') {
            $deliveryType.addClass('active');
          //  $('#new_gift_card').get(0).reset();
            $('#e-gift').css('display','none');
            $('#gift').css('display','block')

        } else {
            $('#recipient-info').removeClass('active');
            $('#gift_card_deliver_to_me').prop('checked', true);
            $('#gift_card_deliver_to_recipient').prop('checked', false);
            //$('#new_gift_card').get(0).reset();

            $('#e-gift').css('display','block');
            $('#gift').css('display','none')

        }
    });

    $('label .radio_buttons').click(function () {
        var $recipient = $('#recipient-info');
        $recipient.removeClass('active');
        if ($(this).attr('id') == 'p_gift_card_deliver_to_recipient') {
            $recipient.addClass('active');

            $('#p_gift_card_shipping_address_attributes_address_1').attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given  correct Address'
            });

            var $shipping_city = $('#p_gift_card_shipping_address_attributes_city');
            $shipping_city.attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given  correct City'
            });

            $shipping_city.attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given  correct City'
            });

            $('#p_gift_card_shipping_address_attributes_country').attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given correct Country'
            });
        }
        else{
            $('#p_gift_card_shipping_address_attributes_address_1').removeAttr('data-validation data-validation-error-msg');
            $('#p_gift_card_shipping_address_attributes_city').removeAttr('data-validation data-validation-error-msg');
            $('#p_gift_card_shipping_address_attributes_country').removeAttr('data-validation data-validation-error-msg');
            }
    });
});

$(document).ready(function () {
    $('.gift_card_card_type input').attr('value', 'E-GIFT CERTIFICATE');

    $('.gift-certificate.tab').click(function () {
        var target = $(this).attr('data-url');

        $('.gift-certificate').removeClass('active');

        $(this).addClass('active');
        var $deliveryType = $('.deliver-type');
        $deliveryType.removeClass('active');

        if (target == 'normal-gift') {
            $deliveryType.addClass('active');
          //  $('#new_gift_card').get(0).reset();
            $('#e-gift').css('display','none');
            $('#gift').css('display','block')

        } else {
            $('#recipient-info').removeClass('active');
            $('#gift_card_deliver_to_me').prop('checked', true);
            $('#gift_card_deliver_to_recipient').prop('checked', false);
            //$('#new_gift_card').get(0).reset();

            $('#e-gift').css('display','block');
            $('#gift').css('display','none')

        }
    });
    $(".floatcheck").on("click", function(){
   alert($(this).text());
})​
        $('.decimalcheck').on('click',function () {
            var parent = $(this).closest('form')
            //console.log(parent);
               var val =  parent.find('.floatcheck').val();
              // console.log(val);
              if(val<1)
              {
                parent.find('.dis').html('<span id="size-error">Enter Amount Above 0</span>');
                parent.find('.floatcheck').css('border-color','red');
                return false;
              }
                else if(val%1!=0)
                {

                parent.find('.dis').html('<span id="size-error">Enter Whole Numbers. eg:Rs.100,250 or $1,$2 etc</span>');
                parent.find('.floatcheck').css('border-color','red');
                return false;
                }else
                 {return true;}
                });


    //$('label .radio_buttons').click(function () {
    //    var $recipient = $('#recipient-info');
    //    $recipient.removeClass('active');
    //    if ($(this).attr('id') == 'p_gift_card_deliver_to_recipient') {
    //        $recipient.addClass('active');
    //        $('#gift_card_shipping_address_attributes_address_1').attr({
    //            'data-validation': 'required',
    //            'data-validation-error-msg': 'You have not given  correct Adrress'
    //        });
    //
    //        var $shipping_city = $('#gift_card_shipping_address_attributes_city');
    //        $shipping_city.attr({
    //            'data-validation': 'required',
    //            'data-validation-error-msg': 'You have not given  correct City'
    //        });
    //
    //        $shipping_city.attr({
    //            'data-validation': 'required',
    //            'data-validation-error-msg': 'You have not given  correct City'
    //        });
    //
    //        $('#gift_card_shipping_address_attributes_country').attr({
    //            'data-validation': 'required',
    //            'data-validation-error-msg': 'You have not given correct Country'
    //        });
    //
    //        // $('#gift_card_email').attr({
    //        //     'data-validation': 'required',
    //        //     'data-validation-error-msg': 'You have not given correct Email'
    //        // });
    //
    //
    //        //  $('#gift_card_shipping_address_attributes_address_1').attr('data-validation','required')
    //
    //    }
    //});
});