package com.bookdabang.khn.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.EventBoardVo;
import com.bookdabang.khn.etc.UploadFile;

public interface EventService {
	public List allEventList() throws Exception; // 전체 게시글 로드

	public boolean insertEvent(EventBoardVo newEvent) throws Exception; // 게시글 등록

	public EventBoardVo readDetailEvent(int no) throws Exception; // 게시글 세부 내용 읽어오기

	public int deleteEvent(int no) throws Exception; // 게시글 삭제

	public Timestamp pageViewCheck(String ipAddr, int no);

	public List allBestList() throws Exception; // 베스트 게시글 불러오기


}
