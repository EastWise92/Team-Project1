$('.menuSub').hide();
$('.menu').on('click',function(){
    $(this).next().slideToggle();
    $(this).parent().siblings().find('ul').slideUp();
})

$('.menuSub2').hide();
$('.menu2').on('click',function(){
    $(this).next().slideToggle();
    $(this).parent().siblings().find('ul').slideUp();
})

