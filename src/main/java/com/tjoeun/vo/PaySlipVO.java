package com.tjoeun.vo;

import lombok.Data;

@Data
public class PaySlipVO {
	
	private int empno; // 사원번호
	private Double basepay; // 기본급
	private Double posallow; // 직책수당
	private Double annualpay; // 근속수당
	private Double extpay; // 연장수당
	private Double nightpay; // 야근수당
	private Double holypay; // 주말수당
	private Double bonus; // 상여금
	private Double etcpay; // 기타
	private Double foodfee; // 식비
	private Double transefee; // 교통비
	private Double incometax; // 소득세
	private Double localtax; // 지방세
	private Double nationpen; // 국민연금
	private Double empinsure; // 고용보험
	private Double healthinsure; // 건강보험
	private Double etcdeduce; // 기타 공제
	
}
