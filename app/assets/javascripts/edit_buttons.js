$(document).ready(function(){

  $(document).on('click', '#edit-teacher-classroom', showXs)

})

var showXs = function(e){
  var table = $(e.target).siblings('table')
  var xElem = $(table).find('i').parent()

  if (xElem.hasClass('disp-no')){
    xElem.removeClass('disp-no')
  } else {
    xElem.addClass('disp-no')
  }
}
