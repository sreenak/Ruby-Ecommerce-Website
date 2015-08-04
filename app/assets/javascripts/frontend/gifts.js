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
            $('.gift_card_card_type input').attr('value', 'GIFT CERTIFICATE')
          //  $('#new_gift_card').get(0).reset();
            $('#e-gift').css('display','none')
            $('#gift').css('display','block')

        } else {
            $('.gift_card_card_type input').attr('value', 'E-GIFT CERTIFICATE');
            $('#recipient-info').removeClass('active');
            $('#gift_card_deliver_to_me').prop('checked', true);
            $('#gift_card_deliver_to_recipient').prop('checked', false);
            //$('#new_gift_card').get(0).reset();

            $('#e-gift').css('display','block')
            $('#gift').css('display','none')

        }
    });


    $('label .radio_buttons').click(function () {
        var $recipient = $('#recipient-info');
        $recipient.removeClass('active');
        if ($(this).attr('id') == 'p_gift_card_deliver_to_recipient') {
            $recipient.addClass('active');
            $('#gift_card_shipping_address_attributes_address_1').attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given  correct Adrress'
            });

            var $shipping_city = $('#gift_card_shipping_address_attributes_city');
            $shipping_city.attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given  correct City'
            });

            $shipping_city.attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given  correct City'
            });

            $('#gift_card_shipping_address_attributes_country').attr({
                'data-validation': 'required',
                'data-validation-error-msg': 'You have not given correct Country'
            });

            // $('#gift_card_email').attr({
            //     'data-validation': 'required',
            //     'data-validation-error-msg': 'You have not given correct Email'
            // });


            //  $('#gift_card_shipping_address_attributes_address_1').attr('data-validation','required')

        }
    });
});