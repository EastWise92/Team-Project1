	    // modal 창 띄우기
	    const open = () => {
	    	document.querySelector(".modal").classList.remove("hidden");
	    }
	
	    const close = () => {
	        document.querySelector(".modal").classList.add("hidden");
	    }
	
	    document.querySelector(".send-open").addEventListener("click", open);
	    document.querySelector(".closeBtn-out").addEventListener("click", close);
	
	    
	    // 수신참조자 추가하기 -> 전체 (선택, 해제)
	    $(document).ready(function() {
	        $('#refer-listAll').click(function() {
	            if($('#refer-listAll').prop('checked')){
	                $('input[name=refer-list]:checkbox').prop('checked', true);
	            }else {
	                $('input[name=refer-list]:checkbox').prop('checked', false);
	            }
	        });
	    });
	
	    /* refer-insert */
	
	    $(document).ready(function() {
	        $('.refer-insert').click(function() {
	
	            var rowData = new Array();
	            var tdArr = new Array();
	            var checkbox = $("input[name=refer-list]:checked");
	            
	            
	            checkbox.each(function(i) {
		
		            var tr = checkbox.parent().parent().eq(i);
		            var td = tr.children();
		            
		            console.log('checkbox: ' + checkbox.parent().parent().eq(i));
		            console.log('tr.children(): ' + tr.children());
		            console.log('tr: ' + tr);
		            console.log('td: ' + td);
		            
		            rowData.push(tr.text());
		            
		            console.log('rowData: ' + rowData);
		            
		            var name = td.eq(1).text();
		            var dept = td.eq(2).text();
		            var position = td.eq(3).text();
		            
		            tdArr.push(name);
		            tdArr.push(dept);
		            tdArr.push(position);
					
		            console.log('name: ' + name);
		            console.log('dept: ' + dept);
		            console.log('position: ' + position);
		            console.log('tdArr: ' + tdArr);
		            
		            $('#refer-right-section > tbody:last').append('<tr><td><input type="checkbox" name="D-refer-list" id="D-refer-list" style="height: 15px; margin-top: 6px;"></td>'
		                +'<td>'+ name +'</td>'
		                +'<td>'+ dept +'</td>'
		                +'<td>'+ position +'</td></tr>'
		            );
	                
		            for (var i = 1; i < tdArr.length; i++) {
	                    if($('input[name=refer-list]:checked')) {
	                        $(this).parent().parent().remove();
	                        $('input[id=refer-listAll]:checkbox').prop('checked', false);
	                    }
	                }
	            });
	        });
	    });
	    
	    /* refer-delete */
	    
	    $(document).ready(function() {
	        $('#D-refer-listAll').click(function() {
	            if($('#D-refer-listAll').prop('checked')){
	                $('input[name=D-refer-list]:checkbox').prop('checked', true);
	            }else {
	                $('input[name=D-refer-list]:checkbox').prop('checked', false);
	            }
	        });
	    });
	    
	    
	    $(document).ready(function() {
	        $('.refer-delete').click(function() {
	
	            var rowData = new Array();
	            var tdArr = new Array();
	            var checkbox = $("input[name=D-refer-list]:checked");
	            
	            checkbox.each(function(i) {
		
	            var tr = checkbox.parent().parent().eq(i);
	            var td = tr.children();
	            
	            rowData.push(tr.text());
	            
	            var name = td.eq(1).text();
	            var dept = td.eq(2).text();
	            var position = td.eq(3).text();
	            
	            tdArr.push(name);
	            tdArr.push(dept);
	            tdArr.push(position);
	
	            console.log('name: ' + name);
	            console.log('tdArr: ' + tdArr);
	            $('#refer-left-section > tbody:last').append('<tr><td><input type="checkbox" name="refer-list" id="refer-list" style="height: 15px; margin-top: 6px;"></td>'
	                +'<td>'+ name +'</td>'
	                +'<td>'+ dept +'</td>'
	                +'<td>'+ position +'</td></tr>');
	            
	                for (var i = 1; i < tdArr.length; i++) {
	                    if($('input[name=D-refer-list]:checked')){
	                        $(this).parent().parent().remove();
	                        $('input[id=D-refer-listAll]:checkbox').prop('checked', false);
	                    }
	                }
	            });
	        });
	    });
	    
	    $(document).ready(function() {
	        $('#addRefer').click(function() {
	        	
	            var tdArr = new Array();
	            var checkbox = $("input[name=D-refer-list]");
	            
	            checkbox.each(function(i) {
		            var tr = checkbox.parent().parent().eq(i);
		            var td = tr.children();
		            
		            var name = td.eq(1).text();
		            var dept = td.eq(2).text();
		            var position = td.eq(3).text();
		            
		            tdArr.push(name);
		            tdArr.push(dept);
		            tdArr.push(position);
	            	
		            var str = name + "_" + position +"_" + dept + ", ";
		            
		            $('#referList').append(str);		            	
		           
		            $("#refer-right-section").empty();
                    $("#refer-right-section").append(
                    		'<tr style="border-bottom: 1px solid black;">'
                            +'<th>'
                            +'<input type="checkbox" name="refer-listAll" id="refer-listAll" style="height: 15px; margin-top: 6px;">'
                            +'</th>'
                            +'<th>이 름</th>'
                            +'<th>부 서</th>'
                            +'<th>직 책</th>'
                        +'</tr>'
                    );
                    $("#refer-right-section").append(
 				    	'<tbody></tbody>'
                    );
	            });
	            document.querySelector("#addRefer").addEventListener("click", close);
	        });
	    });