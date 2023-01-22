package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tjoeun.vo.*;

// mapper 연결에 사용하는 인터페이스
public interface MyBatisDAO {

	// emp
	int confirmEmpno(int empno);
	EmpVO selectlogin(int empno);
	EmpVO registerCheck(String empno);	
	void register(EmpVO vo);
	void registerUpdate(EmpVO vo);
		
	// findID
	int findID(EmpVO vo);
	EmpVO foundID(EmpVO vo);
	
	// findPW
	int findPW(EmpVO vo);
	void updatePW(EmpVO vo);
	EmpVO foundPW(EmpVO vo);
	
	// board
	int selectCount(String category);
	ArrayList<BoardVO> selectList(Param param);
	int selecCountMulti(Param param);
	ArrayList<BoardVO> selectListMulti(Param param);
	int selectQNACount(String category);
	ArrayList<BoardVO> selectQNAList(Param param);
	int countByDept(int deptno);
	ArrayList<EmpVO> selectByDept(HashMap<String, Integer> hmap);
	int mywrite_selectCount(int empno);
	ArrayList<BoardVO> mywrite_selectList(HashMap<String, Integer> myhmap);
	void boardinsert(BoardVO vo);
	void answerinsert(BoardVO vo);
	void increment_hit(int idx);
	BoardVO selectContentByIdx(int idx);
	int selectCommentCount(int idx);
	ArrayList<BoardVO> selectCommentList(HashMap<String, Integer> hmap);
	void contentdelete(BoardVO vo);
	void boardupdate(BoardVO vo);
	void commentinsert(BoardVO vo);
	void commentdelete(int idx);
	ArrayList<BoardVO> selectNoticeList(String string); // 메인 공지사항 리스트
	ArrayList<BoardVO> selectDataList(String category); // 메인 자료실 리스트
	void insertattach(BoardVO vo);
	void data_update(BoardVO vo); // 첨부파일 수정
	
	// report
	int selectReportCount();
	ArrayList<ReportVO> seletReportList(HashMap<String, Integer> hmap);
	ReportVO selectReportByIdx(int idx);
	void insertReport(ReportVO reportVO);
	void deleteReport(ReportVO vo);
	void updateReport(ReportVO vo);
	void incrementReport(int idx);
	int selectCountSearch(ReportVO reportVO);
	ArrayList<ReportVO> selectListSearch(ReportVO reportVO);
	
	// message
	void sendmessage(MessageVO vo);
	ArrayList<MessageVO> receiveMessageSelectList(Param param);
	int receiveMessageSelectCount(int empno);
	ArrayList<MessageVO> sendMessageSelectList(Param param);
	int sendMessageSelectCount(int empno);
	MessageVO messageSelectByIdx(int idx);
	void updateStatus(int idx);
	int trashMessageSelectCount(int empno);
	ArrayList<MessageVO> trashMessageSelectList(Param param);
	void messageGoTrash(MessageVO meo);
	void messageRestore(MessageVO meo);
	void messageDelete(MessageVO meo);
	int noreadCount(int empno);
	int receiverSelect(String parameter);
	int selectReceiveMessageCountMulti(Param param);
	ArrayList<MessageVO> selectReceiveMessageListMulti(Param param);
	int selectSendMessageCountMulti(Param param);
	ArrayList<MessageVO> selectSendMessageListMulti(Param param);
	int selectTrashMessageCountMulti(Param param);
	ArrayList<MessageVO> selectTrashMessageListMulti(Param param);

	// todo
	int maxidx(TodoVO vo);
	void todoinsert(TodoVO vo);
	ArrayList<TodoVO> todolist(TodoVO todovo);
	void todoupdateS(TodoVO vo);
	void tododelete(TodoVO vo);
	void todoupdate(TodoVO vo);
	ArrayList<TodoVO> caltodolist(TodoVO todo);
	ArrayList<TodoVO> caltodolistShareset(TodoVO todo);
	
	// meetroom
	void meetroominsert(MeetRoomVO mvo);
	ArrayList<MeetRoomVO> list103(MeetRoomVO mvo);
	ArrayList<MeetRoomVO> list222(MeetRoomVO mvo);
	ArrayList<MeetRoomVO> list503(MeetRoomVO mvo);
	ArrayList<MeetRoomVO> list710(MeetRoomVO mvo);
	ArrayList<MeetRoomVO> list901(MeetRoomVO mvo);
	ArrayList<MeetRoomVO> list907(MeetRoomVO mvo);
	
	// manager
	int countwaiting(); // emp.xml
	ArrayList<EmpVO> selectwaiting(HashMap<String, Integer> hmap); // emp.xml
	void account_approval(EmpVO vo); // emp.xml
	int countemp(); // emp.xml
	ArrayList<EmpVO> selectemp(HashMap<String, Integer> hmap); // emp.xml
	int countByName(String searchname); // emp.xml
	ArrayList<EmpVO> selectByName(Param param); // emp.xml
	int countByMultiEmp(Param param); // emp.xml
	ArrayList<EmpVO> selectByMultiEmp(Param param); // eml.xml
	void updatePMS(EmpVO vo); // emp.xml
	int AllBoardCount(); // board.xml
	ArrayList<BoardVO> AllBoardSelect(Param param); // board.xml
	int NoCatCountMulti(Param param); // board.xml
	ArrayList<BoardVO> NoCatSelectMulti(Param param); // board.xml
	void categoryupdate(BoardVO vo); // board.xml
	
	// attend
	int countAttnedAll(); 
	ArrayList<AttendVO> selectAttendAll(HashMap<String, Integer> hmap); 
	int countAttendByDept(int deptno); 
	ArrayList<AttendVO> selectAttendByDept(HashMap<String, Integer> hmap);
	int countAttendByDate(String searchdate);
	ArrayList<AttendVO> selectAttendByDate(Param param);
	int countAttendByName(String searchname);
	ArrayList<AttendVO> selectAttendByName(Param param);
	int countAttendByDeptDate(Param param);
	ArrayList<AttendVO> selectAttendByDeptDate(Param param);
	int countAttendByDateName(Param param);
	ArrayList<AttendVO> selectAttendByDateName(Param param);
	int countDayoffByEmpno(int empno);
	ArrayList<AttendVO> selectDayoffByEmpno(Param param);
	PaySlipVO showPaySlip(Param param); // 급여명세서


	// approval
	int approvalCount_YET(int empno);
	int approvalCount_UNDER(int empno);
	int approvalCount_DONE(int empno);
	List<ApprovalVO> selectRecentList(Param param);
	List<ApprovalVO> selectRecentList1(Param param);
	List<ApprovalVO> selectRecentList2(Param param);

	List<EmpVO> selectMemberAllForApproval(EmpVO empvo);
	int insertLetterOfApproval(ApprovalVO vo);
	int insertLetterOfApproval2(ApprovalVO vo);
	int insertLetterOfApproval3(ApprovalVO vo);
	ApprovalVO selectApprovalListDetail(int appNo);

	int listCount(Param param);
	ArrayList<ApprovalVO> selectApprovalList(Param param);

	List<EmpVO> selectSearchedMemberForApproval(String searchData, EmpVO empvo);
	int rejectUpdate(ApprovalVO vo);
	List<EmpVO> getSearchMember(String userName);

	int approved1(int appNo);
	int approved2(int appNo);
	int approved3(int appNo);
	int canceled1(int appNo);
	int canceled2(int appNo);
	int canceled3(int appNo);
	int insertApproval(ApprovalVO vo);
	int insertAppLeave(ApprovalVO vo);
	int insertReceiveRef(ApprovalVO vo);
	int insertExpenseReport(ApprovalVO vo);
	int insertExpenseReport2(ApprovalVO vo);
	int insertExpenseReport3(ApprovalVO vo);
	ApprovalVO selectExpenseReportListDetail(int appNo);
	ApprovalVO viewAppLeaveList(int appNo);

	// 검색
	int AselecCountMulti(Param param);
	ArrayList<ApprovalVO> AselectListMulti(Param param);
	List<EmpVO> selectMemberByName(String searchName);
	int updateApprovalFromCancel(Map<String, Object> bodyMap);
	
	int myWriteSelecCountMulti(Param param);
	ArrayList<BoardVO> myWriteselectListMulti(Param param);
}
