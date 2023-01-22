// 일정 입력 창 열기
var year;
var month;
var date;

var curr_year;
var curr_month;
var curr_date;

var now;

var idx;

//입력 폼 모달 열기
function openInsertTodo(year, month, date) {

	this.year = year;
	this.month = (Number(month) + 1);
	this.date = date;
	
    $('.inserttodo').css('display','block');
    $('.inserttodoback').css('display','block');
    
	$('#endtime').val('');
	$('#content').val('');
	$('#colorcode').val('');
	$('#colorcode').css('background-color','#ffffff');
	$('#shareset').val('');
 
}

//입력 폼 모달 닫기
function closeInsertTodo() {
    $('.inserttodo').css('display','none');
    $('.inserttodoback').css('display','none');
}

// 일정 등록
function todoinsert(year, month, date) {
	
	this.curr_year = year;
	this.curr_month = (Number(month) + 1);
	this.curr_date = date;
	
	if (this.year == curr_year && this.month == curr_month && this.date == curr_date) {
		now = 1;
	} else {
		now = 0;
	}
	
	let time = $('#endtime').val();
	let content = $('#content').val();
	let empno = $('#todoempno').val();
	let colorcode = $('#colorcode option:selected').val();
	let shareset = $('#shareset option:selected').val();
	
	dateinfo = this.year + '-' + this.month + '-' + this.date;
	
	if (time == null || time == "") {		
		c = content;
	} else {
		c = "~" + time + ", " +  content;
	}
	
	if (content == null || content == "") {
		alert('내용을 입력하세요.');
		return;
	} else if (colorcode == null || colorcode == "") {
		alert('배경색을 지정해주세요.');
		return;
	} else if (shareset == null || shareset == "") {
		alert('공개 범위를 지정해주세요.');
		return;
	}
	
	// jQuery Ajax
	$.ajax({
		type: 'POST',
		url: '/Intranet_Project/todo/todo_insert',
		data: {
			content : c,
			empno : empno,
			colorcode : colorcode,
			shareset : shareset,
			dateinfo : dateinfo
		},
		success: res => {
			
//			res를 클래스 객체로 받아올 경우
//			let data = $(res).find('TodoVO');
//			let idx = data.children().eq(0).text();
//			let content = data.children().eq(3).text();
//			let shareset = data.children().eq(5).text();
//			let colorcode = data.children().eq(6).text();
			
			$('#endtime').val('');
			$('#content').val('');
			$('#colorcode').val('');
			$('#colorcode').css('background-color','#ffffff');
			$('#shareset').val('');

			if (this.now == 1) {
				$('.todoarea').append('<div id="right_todo_div' + res + '"><input id="' + res + 'status2" type="checkbox" onclick="updatestatus(' + res + ',' + empno + ',2)"><p style="background:' + colorcode + '">' + c + '</p></div>');
				$('.todo_view_area').append('<div id="todo_view_div' + res + '">' + 
												'<input id="' + res + 'status1" type="checkbox" onclick="updatestatus(' + res + ',' + empno + ',1)">' + 
												'<h5 style="background:' + colorcode + '">' + c + '</h5>' +
												'<div>' +
													'<div class="imghover">' +
														'<img src="../images/edit.png" onclick="openUpdateTodo(' + res + ',\'' + c +'\',\'' + colorcode + '\',\'' + shareset + '\')">' +
														'<img src="../images/edithover.png">' +
													'</div>' +
												'</div>' +
												'<div style="margin-left: 30px;">' + 
													'<div class="imghover">' +
														'<img src="../images/trash.png" onclick="deletetodo(' + res +')">' +
														'<img src="../images/trashhover.png">' +
													'</div>' +
												'</div>' +
											'</div>'
				);
				
			}
			
			$('#area_'+this.date).append('<p style="background: '+ colorcode +'">'+ c +'</p>');
			closeInsertTodo();
	
		},
		error: err => console.log('일정 등록 실패' + err)
	});
	
}

// 입력, 수정하면서 컬러코드 선택시 배경 즉시 적용
function changeBack() {
	let colorcode = $('#colorcode option:selected').val();
	
	$('#colorcode').css('background-color',colorcode);
}

// 일정 체크박스 변경
function updatestatus(idx, empno, pos) {
	
	let status = null;
	
	if (pos == 1){
		status = $('#'+idx+'status1').prop('checked');
	} else {
		status = $('#'+idx+'status2').prop('checked');
	}

	// jQuery Ajax
	$.ajax({
		type: 'POST',
		url: '/Intranet_Project/todo/todo_updatestatus',
		data: {
			status : status,
			idx : idx,
			empno : empno
		},
		success: res => {
			
			$('#'+idx+'status1').prop('checked',status);
			$('#'+idx+'status2').prop('checked',status);
		
		},
		error: err => console.log('일정 상태 변경 실패' + err)
	});
}

// 일정 삭제
function deletetodo(idx){
	
	if (!confirm("정말 삭제하시겠습니까?")) {
        return;
    } else {
	
		// jQuery Ajax
		$.ajax({
			type: 'POST',
			url: '/Intranet_Project/todo/todo_delete',
			data: {
				idx : idx
			},
			success: res => {
				
				$('#todo_view_div'+idx).remove()
				$('#right_todo_div'+idx).remove()
		
			},
			error: err => console.log('일정 삭제 실패' + err)
		});
    }
}

//수정 폼 모달 열기
function openUpdateTodo(idx, content, colorcode, shareset) {
	this.idx = idx;

	if (content.includes('~')) {
		time = content.split('~')[1].split(',')[0]
		content = content.split(', ')[1]
		$('#updateendtime').val(time);
	} else {
		$('#updateendtime').val('');
	}
	
	$('#updatecontent').val(content);
	$('#updateshareset').val(shareset);
	$('#updatecolorcode').val(colorcode);
	$('#updatecolorcode').css('background-color',colorcode);
	
    $('.updatetodo').css('display','block');
    $('.updatetodoback').css('display','block');
    
    
}

//수정 폼 모달 닫기
function closeUpdateTodo() {
    $('.updatetodo').css('display','none');
    $('.updatetodoback').css('display','none');
}

//입력, 수정하면서 컬러코드 선택시 배경 즉시 적용
function updatechangeBack() {
	let colorcode = $('#updatecolorcode option:selected').val();
	
	$('#updatecolorcode').css('background-color',colorcode);
}

//수정 Ajax
function todoupdate() {
	idx = this.idx;
	
	let time = $('#updateendtime').val();
	let content = $('#updatecontent').val();
	let shareset = $('#updateshareset').val();
	let colorcode = $('#updatecolorcode').val();
	
	if (time == null || time == "") {		
		c = content;
	} else {
		c = "~" + time + ", " +  content;
	}
	
	if (!confirm("정말 수정하시겠습니까?")) {
        return;
    } else {
	
		// jQuery Ajax
		$.ajax({
			type: 'POST',
			url: '/Intranet_Project/todo/todo_update',
			data: {
				idx : idx,
				content : c,
				shareset : shareset,
				colorcode : colorcode
			},
			success: res => {
				
				$('.updatetodo').css('display','none');
			    $('.updatetodoback').css('display','none');
			    location.reload();
					
			},
			error: err => console.log('일정 수정 실패' + err)
		});
    }
	
}


