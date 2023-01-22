<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="searchTemplate_area">
    <div class="result_area">
        <h3>반려 사유</h3>
        <div>
            <textarea id="cancelReason" name="cancelReason" style="height: 250px; margin-top: 20px"></textarea>
        </div>
    </div>
    <div class="button_area">
        <button onclick="cancelAction()">확인</button>
        <button onclick="closePopup()">닫기</button>
    </div>
    <input type="hidden" id="approvalSeq" name="approvalSeq"/>
    <input type="hidden" id="role" name="role"/>
</div>
<script>
  (function () {
    $(".searchTemplate_area").hide();
  })();

  function showCancelForm(seq, role) {
    $('#approvalSeq').val(seq);
    $('#role').val(role);

    const height = Math.floor($(".searchTemplate_area").height());
    const scrollTop = Math.floor($("html").scrollTop() / 2);
    $(".searchTemplate_area").css("top", height + scrollTop + 'px');
    $(".searchTemplate_area").show();
  }

  async function cancelAction(){
      if (confirm("정말 반려 처리하시겠습니까?")) {
          const seq = $('#approvalSeq').val();
          const role = $('#role').val();
          if(role === 'A' || role === 'B' || role === 'C'){
              const rolePath = role === 'A' ? 'loacanceled1' : role === 'B' ? 'loacanceled2' : 'loacanceled3';
              await $.ajax({
                  type: "post",
                  url: "${path}/approval/" + rolePath + "?appNo="+seq,
                  success: async function(){
                      let appendTag = '<img src="${path}/images/canceled.png" style="position:absolute; width:130px; height:130px; margin-left:-92px; margin-top:-50px" />';
                      if(role === 'A'){
                          $("#firstA").append(appendTag);
                      }
                      if(role === 'B'){
                          $("#interimA").append(appendTag);
                      }
                      if(role === 'C'){
                          $("#finalA").append(appendTag);
                      }
                      await Swal.fire({
                          icon: 'success',
                          title: '반려 처리했습니다.'
                      });
                  },
                  error: function(){ alert("잠시 후 다시 시도해주세요."); }
              });
              closePopup();
              let mainPath = '${path}/approval/approvalMain';
              console.log('mainPath', mainPath);
              location.href = mainPath;
          }
      }
  }

  function closePopup(){
    $('#approvalSeq').val("");
    $('#cancelReason').val("");
    $('.searchTemplate_area').hide();
  }
</script>