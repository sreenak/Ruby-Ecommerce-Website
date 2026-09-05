
// $('#payu').on('change', function() {
//     console.log($(this).closest("#payu_payment_form")) 
//     $(this).closest("#payu_payment_form").submit(); })

$(document).ready(function () {
    var copyField = function (from, to) {
        $(to).val($(from).val())
    };
    $('input#copy-billing').change(function () {
        if ($(this).is(':checked')) {
            copyField('#order_billing_address_attributes_name', '#order_shipping_address_attributes_name');
            copyField('#order_billing_address_attributes_address_1', '#order_shipping_address_attributes_address_1');
            copyField('#order_billing_address_attributes_address_2', '#order_shipping_address_attributes_address_2');
            copyField('#order_billing_address_attributes_country', '#order_shipping_address_attributes_country');
            copyField('#order_billing_address_attributes_city', '#order_shipping_address_attributes_city');
            copyField('#order_billing_address_attributes_state', '#order_shipping_address_attributes_state');
            copyField('#order_billing_address_attributes_postal_code', '#order_shipping_address_attributes_postal_code');
        } else {
            $('#order_shipping_address_attributes_name, #order_shipping_address_attributes_address_1,#order_shipping_address_attributes_address_2, #order_shipping_address_attributes_country, #order_shipping_address_attributes_city, #order_shipping_address_attributes_state, #order_shipping_address_attributes_postal_code').val('')
        }
    })
});