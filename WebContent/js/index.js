$('.selected').click(function(){
    var $href = $(this).attr('href');
    layer_popup($href);
});

$(".menu>a").click(function(){
    var submenu = $(this).next("ul");

    if( submenu.is(":visible") ){
        submenu.slideUp();
    }else{
        submenu.slideDown();
    }
});


