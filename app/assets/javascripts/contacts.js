$(document).ready(function(){
  $('.dialer_num').on('click', function(e){
    e.preventDefault();
    var num = $($(this).find("p")[0]).html();
    num = num.match(/^\d/)[0]
    $($('.number')[0]).append(num);
    var data = {
      number: $($('.number')[0]).html()
    };
    $.ajax({
      url: 'search',
      type: "get",
      data: data
    });
  });
  $('.remove_num').on('click', function(e){
    e.preventDefault();
    var to_set = "";
    var val = $($('.number')[0]).html();
    for (var i = 0; i <= $($('.number')[0]).html().length - 2; i++) {
      to_set += val[i];
    };
    $($('.number')[0]).html(to_set);
    var data = {
      number: $($('.number')[0]).html()
    };
    $.ajax({
      url: 'search',
      type: "get",
      data: data
    });
  });
});
