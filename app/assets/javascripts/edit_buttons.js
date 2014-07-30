$(document).ready(function(){

  $(document).on('click', '#edit-teacher-classroom', showXs)
  $(document).on('click', 'i', deleteElem)
})

var showXs = function(e){
  var table = $(e.target).siblings('table')
  var elem = $('<td class = "pad-top-15 txt-rt pad-r-5"><i class="fa fa-times ft-sz-1 pad-l-20"></i></td>')
  var data = table.children('tbody').children('tr')

  if (data.children('td').children('i').length >0 ){
    data.children('td').children('i').remove()
  }
  else{
    data.append(elem)
  }

}
