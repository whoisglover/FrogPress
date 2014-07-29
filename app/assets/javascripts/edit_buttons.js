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


// <td class = "pad-top-15 txt-rt disp-no pad-r-5"><i class="fa fa-times ft-sz-1 pad-l-20"></i></a>
//         </td>
