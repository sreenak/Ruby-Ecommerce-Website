$(document).ready(function () {
    var copyField = function (from, to) {
        $(to).val($(from).val())
    };
    $('input#copy-billing-user').change(function () {
        if ($(this).is(':checked')) {
            copyField('#user_billing_address_attributes_name', '#user_shipping_address_attributes_name');
            copyField('#user_billing_address_attributes_address_1', '#user_shipping_address_attributes_address_1');
            copyField('#user_billing_address_attributes_address_2', '#user_shipping_address_attributes_address_2');
            copyField('#user_billing_address_attributes_country', '#user_shipping_address_attributes_country');
            copyField('#user_billing_address_attributes_city', '#user_shipping_address_attributes_city');
            copyField('#user_billing_address_attributes_state', '#user_shipping_address_attributes_state');
            copyField('#user_billing_address_attributes_postal_code', '#user_shipping_address_attributes_postal_code');
        } else {
            $('#user_shipping_address_attributes_name, #user_shipping_address_attributes_address_1,#user_shipping_address_attributes_address_2, #user_shipping_address_attributes_country, #user_shipping_address_attributes_city, #user_shipping_address_attributes_state, #user_shipping_address_attributes_postal_code').val('')
        }
    })

    
});


