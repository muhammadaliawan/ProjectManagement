$(document).ready(function(){
  $('body').on('click', '.check', function(event) {
    $('.check').prop('checked', false);
    $(event.target).prop('checked', true);
  });
});
