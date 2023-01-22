// 회원가입으로 요청된 계정 승인
function approvalEMP(empno) {
	
	let tr = document.getElementById('tr'+empno);
	
	let position_form = document.getElementById('position'+empno);
	let position = position_form.options[position_form.selectedIndex].value;
	
	let dept_form = document.getElementById('deptno'+empno);
	let deptno = dept_form.options[dept_form.selectedIndex].value;
	
	let incnum = document.getElementById('incnum'+empno).value;
	let hiredate = document.getElementById('hiredate'+empno).value;
	
	let permission = document.querySelector('input[name="permission'+empno+'"]:checked').value;						
	
	if (incnum.length == 0) {
		alert('전화번호를 적어주세요.');
		return;
	}
	if (hiredate.length == 0) {
		alert('고용일을 적어주세요.');
		return;
	}
	
	let empvo = {
		empno : empno,
		position : position,
		deptno : deptno,
		incnum : incnum,
		hiredate : hiredate,
		permission : permission
	};
	
	httpRequest = new XMLHttpRequest();
	/* httpRequest의 readyState가 변화했을때 함수 실행 */
    httpRequest.onreadystatechange = () => {
	    if (httpRequest.readyState === XMLHttpRequest.DONE) {
		      if (httpRequest.status === 200) {
		    	  alert('승인되었습니다.');
		    	  tr.remove();
		      } else {
		        alert('승인 실패');
		      }
		}
    };
    /* Post 방식으로 요청 */
    httpRequest.open('POST', 'account_approvalOK', true);
    /* Response Type을 Json으로 사전 정의 */
    httpRequest.responseType = "json";
    /* 요청 Header에 컨텐츠 타입은 Json으로 사전 정의 */
    httpRequest.setRequestHeader('Content-Type', 'application/json');
    /* 정의된 서버에 Json 형식의 요청 Data를 포함하여 요청을 전송 */
    httpRequest.send(JSON.stringify(empvo));
			
};

// 계정의 권한 수정 
function updatePMS(empno, set) {
	httpRequest = new XMLHttpRequest();

    httpRequest.onreadystatechange = () => {
	    if (httpRequest.readyState === XMLHttpRequest.DONE) {
		      if (httpRequest.status === 200) {
		    	  alert('권한이 수정되었습니다.');
		      } else {
		        alert('권한 부여 실패');
		      }
		}
    };
    
	let empvo = {
		empno : empno,
		permission : set
	};

    httpRequest.open('POST', 'updatePMS', true);
    httpRequest.responseType = "json";
    httpRequest.setRequestHeader('Content-Type', 'application/json');
    httpRequest.send(JSON.stringify(empvo));
};

// 글관리 열기 버튼이 눌렸을 때 체크박스, 숨어있던 버튼들 나오게
function openBoardManage() {
	
	var x = document.getElementsByClassName('boardcheck');
	for(var i = 0; i < x.length; i++){
		x[i].style.display = 'inline';
	}
	
	document.getElementById('boardcheckall').style.display = 'inline';
	document.getElementById('DeleteBoardbtn').style.display = 'inline';
	document.getElementById('MoveBoardbtn').style.display = 'inline';
	document.getElementById('BoardManagebtn').value= '글관리 닫기';
	document.getElementById('BoardManagebtn').setAttribute('onclick','closeBoardManage()');
	
	fetch('checksession?data=true', {
		method: 'GET'
	}).then(response => {
		if (!response.ok) {
			console.log(response);
		}
	});
};

//글관리 닫기 버튼이 눌렸을 때 체크박스, 숨어있던 버튼들 없어지게
function closeBoardManage() {
	
	var x = document.getElementsByClassName('boardcheck');
	for(var i = 0; i < x.length; i++){
		x[i].style.display = 'none';
	}
	
	document.getElementById('boardcheckall').style.display = 'none';
	document.getElementById('DeleteBoardbtn').style.display = 'none';
	document.getElementById('MoveBoardbtn').style.display = 'none';
	document.getElementById('BoardManagebtn').value= '글관리 열기';
	document.getElementById('BoardManagebtn').setAttribute('onclick','openBoardManage()');
	
	fetch('checksession?data=false', {
		method: 'GET'
	}).then(response => {
		if (!response.ok) {
			console.log(response);
		}
	});
};

// 전체 체크버튼 눌러서 전체 체크, 해제
document.getElementById('boardcheckall').addEventListener('click', function() {
	
	var x = document.getElementsByClassName('boardcheck');
	
	if (boardcheckall.checked == true) {
		for(var i = 0; i < x.length; i++){
			x[i].checked = true;
		}
	} else {
		for(var i = 0; i < x.length; i++){
			x[i].checked = false;
		}
	}
});

// 삭제 버튼 눌러서 선택한 글 삭제
document.getElementById('DeleteBoardbtn').addEventListener('click', function() {
	
	var idxs = '';
	var x = document.getElementsByClassName('boardcheck');
	for(var i = 0; i < x.length; i++){
		if (x[i].checked == true){
			idxs += x[i].value + ' '
		}
	}
	
	
	if (idxs.length == 0) {
		alert('삭제할 글을 선택해주세요.');
		return;
	}
	
	if (!confirm("정말 삭제하시겠습니까?")) {
        return;
    } else {

    	fetch('deleteboard?idxs=' + idxs, {
    		method: 'GET'
    	}).then(response => {
    		if (!response.ok) {
    			console.log(response);
    		} else {		
    			location.reload();
    		}
    	});
    }
	
});

// 이동 버튼 눌러서 카테고리 설정 모달창 나오게
document.getElementById('MoveBoardbtn').addEventListener('click', function() {
	
	var idxs = '';
	var x = document.getElementsByClassName('boardcheck');
	for(var i = 0; i < x.length; i++){
		if (x[i].checked == true){
			idxs += x[i].value + ' '
		}
	}
	
	if (idxs.length == 0) {
		alert('이동할 글을 선택해주세요.');
		return;
	}
	
	document.getElementById('idxs').value = idxs;
	document.getElementsByClassName('moveboardback')[0].style.display = 'block';
	document.getElementsByClassName('moveboarddiv')[0].style.display = 'block';
	
});

// 카테고리 설정 모달창 닫기
function closeMoveBoardPop() {
	document.getElementById('idxs').value = null;
	document.getElementsByClassName('moveboardback')[0].style.display = 'none';
	document.getElementsByClassName('moveboarddiv')[0].style.display = 'none';
}

// 모달창에서 카테고리 선택 후 카테고리 수정하는 ajax
document.getElementById('moveboard').addEventListener('click', function() {
	idxs = document.getElementById('idxs').value
	category = document.getElementById('movecategory').value
	
	fetch('moveboard?idxs=' + idxs + '&category=' + category, {
		method: 'GET'
	}).then(response => {
		if (!response.ok) {
			console.log(response);
		} else {		
			location.reload();
		}			
	});
	
});

// 글 한건 삭제
function deletebyMNG(idx) {
	
	if (!confirm("정말 삭제하시겠습니까?")) {
        return;
    } else {

    	fetch('deleteboard?idxs=' + idx, {
    		method: 'GET'
    	}).then(response => {
    		if (!response.ok) {
    			console.log(response);
    		} else {		
    			location.href='move_show_all_board';
    		}
    	});
    }
	
}




