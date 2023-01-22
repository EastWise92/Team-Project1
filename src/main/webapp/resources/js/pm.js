// 창 열기
function pmPop(empno, name){
	
    $('.transpm').css('display','block');
    $('.pmback').css('display','block');
     
    $('#pmreceiver').val(name + '(' + empno + ')');
    $('#pmtitle').val('');
    $('#pmcontent').val('');
    $('#pmfilename').val('');
    
}

// 창 닫기
function closePmPop() {
    $('.transpm').css('display','none');
    $('.pmback').css('display','none');
   
    
}






