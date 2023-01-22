onload = () => {
	
	let ip = window.location.host;
	console.log(ip);
	
// 채팅 서버 주소
	let url = "ws://" + ip + "/Intranet_Project/chatserver";
	
	console.log(url);
	
	// 웹 소켓
	let ws;
	
	let btnConnect = document.querySelector('#btnConnect')
	let name = $("input#user").val();
	
	btnConnect.addEventListener('click', event => {
		 console.log('commentDeleteBtn');
	
		 // 연결하기
			 
		 // 유저명 확인
		 if ($('#user').val().trim() != '') {
			 // 연결
			 ws = new WebSocket(url);
			 
			 // 소켓 이벤트 매핑
			 ws.onopen = function (evt) {
				 console.log('서버 연결 성공');
				 print($('#user').val(), '입장했습니다.');
				 
				 // 현재 사용자가 입장했다고 서버에게 통지(유저명 전달)
				 // -> 1#유저명
				 ws.send('1#' + $('#user').val() + '#');
				 
				 $('#user').attr('readonly', true);
				 $('#btnConnect').attr('disabled', true);
				 $('#btnDisconnect').attr('disabled', false);
				 $('#msg').attr('disabled', false);
				 $('#msg').focus();
			 };
			 
			 ws.onmessage = function (evt) {
				 // print('', evt.data);
				 let index = evt.data.indexOf("#", 2);
				 let no = evt.data.substring(0, 1); 
				 let user = evt.data.substring(2, index);
				 let txt = evt.data.substring(index + 1);
				 
				 if (no == '1') {
					 print2(user);
				 } else if (no == '2') {
					 print(user, txt);
				 } else if (no == '3') {
					 print3(user);
				 }
				 $('#list').scrollTop($('#list').prop('scrollHeight'));
			 };
			 
			 ws.onclose = function (evt) {
				 console.log('소켓이 닫힙니다.');
				 $("input#user").val(name);
			 };
			 
			 ws.onerror = function (evt) {
				 console.log(evt.data);
			 };
		 } else {
			 alert('유저명을 입력하세요.');
			 $('#user').focus();
			 console.log(" 접속실패")
		 }

		 
	});
		 
	// 메세지 전송 및 아이디
	 function print(user, txt) {
		 let temp = '';
		 temp += '<div style="margin-bottom:3px;">';
		 temp += '[' + user + '] ';
		 temp += txt;
		 temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		 temp += '</div>';
		 
		 $('#list').append(temp);
	 }
		 
	 // 다른 client 접속
	 function print2(user) {
		 let temp = '';
		 temp += '<div style="margin-bottom:3px;">';
		 temp += "'" + user + "' 이(가) 접속했습니다." ;
		 temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		 temp += '</div>';
		 
		 $('#list').append(temp);
	 }
		 
	 // client 접속 종료
	 function print3(user) {
		 let temp = '';
		 temp += '<div style="margin-bottom:3px;">';
		 temp += "'" + user + "' 이(가) 종료했습니다." ;
		 temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		 temp += '</div>';
		 
		 $('#list').append(temp);
	 }
	 
	 $('#user').keydown(function() {
		 if (event.keyCode == 13) {
			 $('#btnConnect').click();
		 }
	 });
	 
	 $('#msg').keydown(function() {
		 if (event.keyCode == 13) {
			 
			 // 서버에게 메시지 전달
			 // 2#유저명#메시지
			 ws.send('2#' + $('#user').val() + '#' + $(this).val()); // 서버에게
			 print($('#user').val(), $(this).val()); // 본인 대화창에
			 
			 $('#msg').val('');
			 $('#msg').focus();
			 
		 }
	 });
	 
	 $('#btnDisconnect').click(function() {
		 ws.send('3#' + $('#user').val() + '#');
		 ws.close();
		 
		 $('#user').attr('readonly', false);
		 $('#user').val('');
		 
		 $('#btnConnect').attr('disabled', false);
		 $('#btnDisconnect').attr('disabled', true);
		 
		 $('#msg').val('');
		 $('#msg').attr('disabled', true);
	 });
	
}


