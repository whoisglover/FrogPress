$(document).ready(function(){
  $(document).on('change', "#highcharts-options", switchCharts)
})

var switchCharts = function(e) {
  hideAllCharts()

  var chart_id = $(e.target).val()
  $("#"+chart_id).removeClass('disp-no')
}

var hideAllCharts = function(){

  $('#readability').addClass('disp-no')
}
