<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="searchTemplate_area">
    <div class="inputField_area">
        성 명 : <input type="text" id="employeeName" name="employeeName" class="employeeName"/>
        <button id="emp_search_btn">검색</button>
    </div>
    <hr/>
    <div class="result_area">
        <div>
            <table>
                <thead>
                <tr>
                    <th>이름</th>
                    <th>부서</th>
                    <th>직책</th>
                </tr>
                </thead>
                <tbody id="dataList"></tbody>
            </table>
        </div>
    </div>
    <div class="button_area">
        <button onclick="closePopup()">닫기</button>
    </div>
    <input type="hidden" id="selectedApprover" name="selectedApprover"/>
</div>
<script>

  (function () {
    $(".searchTemplate_area").hide();
    $("#emp_search_btn").on("click", searchEmployee);
  })();

  function showEmployeeSearchForm(src) {
    $(".searchTemplate_area").show();
    const selectedApprover = $(src).attr("name");
    $("#selectedApprover").val(selectedApprover);
  }

  async function searchEmployee() {
    let employeeName = $('#employeeName').val();
    const url = 'searchEmployee?searchName=' + employeeName;
    await fetch(url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    }).then(async data =>  {
      const result = await data.json();
      $("#dataList").empty();
      
      if (result.length === 0){
        $("<tr>").append($("<td colspan='3'>").text('검색 결과가 존재하지 않습니다.')).appendTo($("#dataList"));
      }
      for (let idx in result){
        $("<tr class=emp onclick=\"selectItem("+result[idx].empno+",'"+result[idx].name+"')\">").append(
            $("<td>").text(result[idx].name),
            $("<td>").text(result[idx].deptno),
            $("<td>").text(result[idx].position)
        ).appendTo($("#dataList"));
      }
    });
  }

  function closePopup(){
	  
    $('#employeeName').val("");
    $('#dataList').empty();
    $('.searchTemplate_area').hide();
  }

  function selectItem(empno, empName){
    const approver = $("#selectedApprover").val();

    $("input[id='"+approver+"']").val(empno);
    $("input[id='"+approver+"Name']").val(empName);
    closePopup();
  }
</script>