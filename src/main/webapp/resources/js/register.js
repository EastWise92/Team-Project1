// 비밀번호 중복검사
function passwordCheckFunction() {
	let password1 = $('#password1').val();
	let password2 = $('#password2').val();
	let pcm = $('#passwordCheckMessage');
	// 비밀번호 영문자, 숫자, 특수문자를 모두 포함해야 한다.
	let reg = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{4,16}$/;
	
	// 비밀번호 4자리 이상 16자리 이하로 설정하는 조건 (최대길이 조건 register.jsp 파일 => maxlength)
	if (password1.length < 4) {
		pcm.html('비밀번호는 영문자,숫자,특수문자를 포함한 4 ~ 16자로 설정해야 합니다.');
	} else if (!reg.test(password1)) {
		pcm.html('비밀번호는 영문자,숫자,특수문자를 모두 포함해야 합니다.');
	} else if (password1 != password2) {
		pcm.html('비밀번호가 일치하지 않습니다.');
		$('.change').attr("disabled",true);
	} else {
		pcm.html(' ');
		$('.change').attr("disabled",false);
	}
}

// 이름(한글, 영문만) 정규식
function nameCheckFunction() {
	let name = $('#name').val();
	let pcm = $('#nameCheckMessage');
	let reg = /^[가-힣a-zA-Z]+$/;
	
	if (!reg.test(name)) {
		pcm.html('이름은 한글 또는 영문만 작성하세요.')
	} else {
		pcm.html(' ');
	}
}

// 휴대폰번호 정규식
function pernumCheckFunction() {
	let pernum = $('#pernum').val();
	let pcm = $('#pernumCheckMessage');
	let reg = "/01[016789]-[^0][0-9]{3,4}-[0-9]{3,4}/";
	
	if (!reg.test(pernum)) {
		pcm.html('"-"을 제외한 휴대폰번호를 올바르게 입력하세요.')
	} else {
		pcm.html(' ');
	}
}

// 이메일 정규식
function emailCheckFunction() {
	let email = $('#email').val();
	let pcm = $('#emailCheckMessage');
	let reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	if (!reg.test(email)) {
		pcm.html('이메일을 (@ 포함) 올바르게 입력하세요.')
	} else {
		pcm.html(' ');
	}
}

// ajax, 회원가입 실행 함수
function userRegister() {
	let empno = $('#empno').val();
	let password1 = $('#password1').val();
	let password2 = $('#password2').val();
	let name = $('#name').val();
	let pernum = $('#pernum').val();
	let gender = $('input[name=gender]:checked').val();
	let email = $('#email').val();
	
	// jQuery Ajax
	$.ajax({
		type: 'POST',
		url: './UserRegister',
		data: {
			empno: empno,
			password1: password1,
			password2: password2,
			name: name,
			pernum: pernum,
			gender: gender,
			email: email
		},
		success: res => {
		// 성공
			$('#empno').val('');
			$('#password1').val('');
			$('#password2').val('');
			$('#name').val('');
			$('#pernum').val('');
			$('#email').val('');
			
			switch (res) {
				case '1':
					alert('모든 내용을 입력하세요.')
					break;
				case '2':
					alert('비밀번호가 일치하지 않습니다.')
					break;
				case '3':
					alert('회원가입에 성공했습니다.')
					location.replace('login');
					break;
				case '4':
					alert('회원가입 실패')
					break;
			}
		},
		error: err => console.log('register.js의 회원가입 Ajax 요청 실패' + err)
	});
}

// 아이디 중복검사
function registerCheckFunction() {
	let empno = $('#empno').val();
	
	$.ajax({
		type: 'POST',
		url: './UserRegisterCheck',
		data: {
			empno: empno
		},
		
		success: res => {
			switch (res) {
				case "1":
					alert('아이디를 입력하세요.')
					break;
				case "2":
					alert('이미 사용중인 아이디입니다.')
					break;
				case "3":
					alert('5자리의 숫자를 입력해주세요.')
					break;
				case "4":
					alert('사용 가능한 아이디입니다.')
					break;
			}
		},
		error: err => console.log('register.js의 아이디 중복확인 Ajax 요청 실패' + err)
	});
}

// ======================================================================================
// 비밀번호 변경 창 열기
function changePop() {
    $('.pwchange').css('display','block');
    $('.background').css('display','block');
    $('#checkPassword').val('');
    $('#password1').val('');
    $('#password2').val('');
    $('#passwordCheckMessage').html(' ');
}

//   비밀번호 변경 창 닫기
function closePop() {
    $('.pwchange').css('display','none');
    $('.background').css('display','none');
}

//   ajax, 현재 비밀번호 검사, 비밀번호 변경
function changePassword() {
   let empno = $('#empno').val();
   let password = $('#password').val();
   let checkPassword = $('#checkPassword').val();
   let password1 = $('#password1').val();

   $.ajax ({
      type: 'POST',
      url: './UserRegisterUpdate',
      data:{
         empno: empno,
         password: password,
         checkPassword: checkPassword,
         password1: password1
      },
      success: res => {
         switch (res) {
            case '1':
               alert('비밀번호를 입력하세요')
               break;
            case '2':
               alert('비밀번호가 틀렸습니다.')
               break;
            case '3':
               alert('변경 완료')
               $('.pwchange').css('display','none');
               $('.background').css('display','none');
               break;
         }
      },
      error : e => console.log('요청 실패 : ',e.status)
   });
}



