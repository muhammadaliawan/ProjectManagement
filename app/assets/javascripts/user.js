$(document).ready(function(){
  $('.alert').fadeOut(10000);

  $(document).on('turbolinks:load', function() {
    $('#datetimepicker1').datetimepicker();
    $('#datetimepicker2').datetimepicker();
  });
});
