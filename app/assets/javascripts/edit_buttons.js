$(document).ready(function(){

  $(document).on('click', '#edit-teacher-classroom', showXs)
  $(document).on('click', '#roster i', removeStudent)
  $(document).on('click', '#assignments i', deleteAssignment)

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

var removeStudent = function(e){
  var tableRow = $(e.target).parent().parent()
  var classroomId = getClassroomId()
  var id = getId(e)

  var request = $.ajax({
    url: '/classroom/'+classroomId+'/users/'+id,
    type: 'DELETE'
  })

  request.success(function(e){
    tableRow.remove()
  })

}

var deleteAssignment = function(e){
  var tableRow = $(e.target).parent().parent()
  var id = getId(e)

  var request = $.ajax({
    url: '/assignment/'+id,
    type: 'DELETE'
  })

  request.success(function(e){
    tableRow.remove()
  })

}



var getClassroomId = function(){
  var classroomURL = window.location.pathname.split('/')
  return classroomURL[2]
}

var getId = function(e){
  return $(e.target).parent().siblings('td')[0].innerHTML
}
