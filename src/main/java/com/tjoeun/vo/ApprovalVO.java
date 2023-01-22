package com.tjoeun.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalVO {

	// Approval(전자결재 메인)
	private int appNo;
	private Date appWriteDate;
	private String firstApprover; // 처음 승인자
	private String interimApprover; // 중간 승인자
	private String finalApprover; // 최종 승인자
	private Date appCheckDate;
	private String appOriginalFileName;
	private String appRenameFileName;
	private int appWriteNo; // emp_empno
	private String appCheckProgress; // '대기', '진행', '완료'
	private String appKinds;
	private String appPresent;
	private String appReason;
	private int deptName;
	private String userName;
	private int rowNum;
	private String rank;
	private String category;

	// App_Receive(수신 참조)
	private int receiveRefNo;
	private int reRefAppNo; // Approval의 appNo(FK)
	private String referList;

	// App_Loa(품의서)
	private int loaNo;
	private int loaAppNo; // Approval의 appNo(FK)
	private String loaTitle;
	private String loaContent;
	private String loaStatus; // 문서 상태
	private String loaPresent; // 결재 현황

	// App_Leave(휴가원)
	private int leaveNo;
	private int leaveAppNo; // Approval의 appNo(FK)
	private String leaveClassify; // 휴가 구분
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date leaveStart;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date leaveFinish;
	private String leaveDetail; // 내용(사유)
	private String leaveStatus; // 문서 상태
	private String leavePresent; // 결재 현황
	private String appEmergncyCall; // 비상 연락망(emp)

	// App_ER(지출 결의서)
	private int erNo;
	private int erAppNo; // Approval의 appNo(FK)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date erDeadline;
	private String erClassify; // 계정과목
	private String allAmount;
	private String erTitle;
	private String erDetail; // 적요
	private String erAmount;
	private String erReference; // 비고
	private String erStatus; // 문서 상태
	private String erPresent; // 결재 현황
	private String moneytaryUnit; // 화폐 단위


}
