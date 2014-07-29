$(document).ready(function(){
var toggle_login = function(){
$('[data-ui="signin_button"]').click(function(){

$('[data-ui="preclick"]').addClass('disp-none');
$('[data-ui="postclick"]').fadeIn();
})
}

toggle_login();
})
