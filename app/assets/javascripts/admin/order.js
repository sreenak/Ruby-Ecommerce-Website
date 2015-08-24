$(document).ready(function(){
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
});