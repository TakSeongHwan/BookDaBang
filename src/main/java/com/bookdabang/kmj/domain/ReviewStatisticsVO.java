package com.bookdabang.kmj.domain;

public class ReviewStatisticsVO {
	private int gradeCount1;
	private int gradeCount2;
	private int gradeCount3;
	private int gradeCount4;
	private int gradeCount5;
	private float gradeRate1;
	private float gradeRate2;
	private float gradeRate3;
	private float gradeRate4;
	private float gradeRate5;
	private int gradeTotal;
	private float gradeAvg;
	
	public ReviewStatisticsVO () {
		super();
	}

	public ReviewStatisticsVO(int gradeCount1, int gradeCount2, int gradeCount3, int gradeCount4, int gradeCount5,
			float gradeRate1, float gradeRate2, float gradeRate3, float gradeRate4, float gradeRate5, int gradeTotal,
			float gradeAvg) {
		super();
		this.gradeCount1 = gradeCount1;
		this.gradeCount2 = gradeCount2;
		this.gradeCount3 = gradeCount3;
		this.gradeCount4 = gradeCount4;
		this.gradeCount5 = gradeCount5;
		this.gradeRate1 = gradeRate1;
		this.gradeRate2 = gradeRate2;
		this.gradeRate3 = gradeRate3;
		this.gradeRate4 = gradeRate4;
		this.gradeRate5 = gradeRate5;
		this.gradeTotal = gradeTotal;
		this.gradeAvg = gradeAvg;
	}

	public int getGradeCount1() {
		return gradeCount1;
	}

	public void setGradeCount1(int gradeCount1) {
		this.gradeCount1 = gradeCount1;
	}

	public int getGradeCount2() {
		return gradeCount2;
	}

	public void setGradeCount2(int gradeCount2) {
		this.gradeCount2 = gradeCount2;
	}

	public int getGradeCount3() {
		return gradeCount3;
	}

	public void setGradeCount3(int gradeCount3) {
		this.gradeCount3 = gradeCount3;
	}

	public int getGradeCount4() {
		return gradeCount4;
	}

	public void setGradeCount4(int gradeCount4) {
		this.gradeCount4 = gradeCount4;
	}

	public int getGradeCount5() {
		return gradeCount5;
	}

	public void setGradeCount5(int gradeCount5) {
		this.gradeCount5 = gradeCount5;
	}

	public float getGradeRate1() {
		return gradeRate1;
	}

	public void setGradeRate1(float gradeRate1) {
		this.gradeRate1 = gradeRate1;
	}

	public float getGradeRate2() {
		return gradeRate2;
	}

	public void setGradeRate2(float gradeRate2) {
		this.gradeRate2 = gradeRate2;
	}

	public float getGradeRate3() {
		return gradeRate3;
	}

	public void setGradeRate3(float gradeRate3) {
		this.gradeRate3 = gradeRate3;
	}

	public float getGradeRate4() {
		return gradeRate4;
	}

	public void setGradeRate4(float gradeRate4) {
		this.gradeRate4 = gradeRate4;
	}

	public float getGradeRate5() {
		return gradeRate5;
	}

	public void setGradeRate5(float gradeRate5) {
		this.gradeRate5 = gradeRate5;
	}

	public int getGradeTotal() {
		return gradeTotal;
	}

	public void setGradeTotal(int gradeTotal) {
		this.gradeTotal = gradeTotal;
	}

	public float getGradeAvg() {
		return gradeAvg;
	}

	public void setGradeAvg(float gradeAvg) {
		this.gradeAvg = gradeAvg;
	}

	@Override
	public String toString() {
		return "ReviewStatisticsVO [gradeCount1=" + gradeCount1 + ", gradeCount2=" + gradeCount2 + ", gradeCount3="
				+ gradeCount3 + ", gradeCount4=" + gradeCount4 + ", gradeCount5=" + gradeCount5 + ", gradeRate1="
				+ gradeRate1 + ", gradeRate2=" + gradeRate2 + ", gradeRate3=" + gradeRate3 + ", gradeRate4="
				+ gradeRate4 + ", gradeRate5=" + gradeRate5 + ", gradeTotal=" + gradeTotal + ", gradeAvg=" + gradeAvg
				+ "]";
	}
	
}
