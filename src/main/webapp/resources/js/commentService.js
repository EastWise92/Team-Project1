function commentInsert() {
	let name = $('#name').val();
	
	console.log(name);
}


function commentService(idx, mode, title, cocontent, gup) {
	
	let cf = document.commentForm; // contentView.jsp 댓글 폼 얻어오기
	
	// 수정 또는 삭제할 댓글 번호 넣어주기
	cf.idx.value = idx;
	
	cf.gup.value = gup;
	
	cf.mode.value = mode;
	
	cf.btntitle.value = title + '하기';
	
	cf.content.value = cocontent;
	
	cf.content.focus();
	
}

function commentDelete(idx) {
	
	let cf = $('#comment_'+idx);
	
	if (!confirm("정말 삭제하시겠습니까?")) {
        return;
    } else {
		$.ajax({
			type: 'POST',
			url: '../board/comment_delete',
			data: {
				idx:idx
			},
			success: res => {		
				cf.remove();
			},
			error: err => alert('댓글 삭제 실패')
		}); 		
    }
}