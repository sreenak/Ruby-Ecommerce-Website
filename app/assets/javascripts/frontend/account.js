$(document).ready(function () {
    var ww = $(window).width()-25;
    var lefw = $(window).width()-65;
    $("#btnsearch").on('click',function(e){
      
        e.preventDefault();
        e.stopPropagation();
        /* Check if field is already displayed, if not, displays it, else, submit */
        if($('#search_container').hasClass('closed')){
            $('#search_container').toggleClass('closed');
            $('#search_container').toggleClass('active');
             $('#search_container i').css('padding-right','5px'); 
             $('#search_container input').css('width',ww)
            $('#hint').html('');
            $('#search_container').animate({
                left: '0',
            }, 200, function(){
                
                /* 
                 * Bind event to hide field when clicking OUT 
                 * use .one() instead of .on() to avoid stacking binding click events on document
                 */
                $(document).one('click', function(){
                    $('#search_container').toggleClass('closed');
                    $('#search_container').toggleClass('active');

                    $('#search_container').animate({
                        left: '-'+lefw,
                    }, 200,function(){

                    $('#search_container i').css('border',0);
                    $('#search_container input').css({'border':0 ,'width':0})
                    $('#search-msg').html('');
                    });
                    

                });   
            });
        }
        else {

            var s =  $("#search").val();
            if(s==""){
        $(".search-key").css({'border':'1px solid #a94442','border-right':0});
      
        $('#search_container i').css({'border':'1px solid #a94442','border-left':0})
        $("#search-msg").html('Please Enter Keyword');
        return false;
    }else{  window.location.href="/search?q="+s;}
          
                   }
    });
    
    $('#search').on('click',function(e){
        /* Needed to avoid closing field when clicking on it */
        e.preventDefault();
        e.stopPropagation();
    });
});

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
//search-large devises
$(".home_searchbar_btn").click(function(){
    var search= $(".search-box-input").val()
    if(search == ""){
    
        $(".search-box-input").css('border-color','red');
        $("#msg").html('Please Enter Keyword');
        return false;
    }

    return true
})

//shop reviews
$(".review-button").click(function(){
    var msg = $("#review_message").val();
    if(msg == ""){
        $("#review_message").css('border-color','#a94442');
        $("#rev-msg").html('Please Enter Message');
        $(".review-box").css('text-align','center');
        return false;
    }return true;
})

// $(window).load(function(){
   
//     if($(window).width() >= 992)
//     {
//        $('.zoomWrapper').each(function(){
//             $(this).removeAttr('class')
//         });

//     }

// })






