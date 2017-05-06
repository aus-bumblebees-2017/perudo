$(document).ready(function() {
  $(".box").click(function(event){
    event.preventDefault();
    console.log("clicked")
    // $(".box").reset();
    $.ajax({
      url: '/details',
      type: 'POST',
      data: {day: $(this).attr("class").slice(-1)}
    })
    .done(function(response){
      html = JSON.parse(response).html;
      day_num = JSON.parse(response).day_num;
      // $(".box-"+day_num).attr('title', html)
      $(".box-"+day_num).html(html);
    })
    
  })
});