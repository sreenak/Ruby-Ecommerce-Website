$(document).ready(function () {
    $('.datepicker1').datepicker({
        "setDate": new Date(),
        "autoclose": true,
        format: 'yyyy-mm-dd'
    });
    $('.datepicker2').datepicker({
        "setDate": new Date(),
        "autoclose": true,
        format: 'yyyy-mm-dd',
    });
    $('.datepicker3').datepicker({
        "setDate": new Date(),
        "autoclose": true,
        format: 'yyyy-mm-dd',
    });
    $('.datepicker4').datepicker({
        "setDate": new Date(),
        "autoclose": true,
        format: 'yyyy-mm-dd',
    });
    $('.filter').click(function () {
        var date1 = $('#q_created_at_gt').val();
        var date2 = $('#q_created_at_lt').val();
        var date3 = $('#q_order_statuses_date_gt').val();
        var date4 = $('#q_order_statuses_date_lt').val();
        if (date1 != '' || date2 != '')
            if (date2 <= date1) {
                $('#dategtlt').css('color', 'red');
                $('#dategtlt').html('To Date should be greater than From Date');
                return false;
            }
        if (date3 != '' || date4 != '') {
            if (date4 <= date3) {
                $('#dategtlt').css('color', 'red');
                $('#dategtlt').html('To Date should be greater than From Date');
                return false;
            }
        }
    });
});