package com.bookdabang.lhs.service;

import java.sql.Timestamp;
import java.util.List;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.Notice;
import com.bookdabang.common.domain.NoticeReply;

public interface NoticeService {

	public List<Notice> entireNotice() throws Exception;
	
	public Notice getContentByNo(int no) throws Exception;
	
	public int getNoticeNo() throws Exception;
	
	public int insertNotice(Notice n) throws Exception;

	public int insertAttachFile(AttachFileVO file, int no) throws Exception;
	
	public List<AttachFileVO> getAttachFile(int no) throws Exception;

	public int deleteNotice(int no) throws Exception;

	public int insertReply(NoticeReply reply) throws Exception;

	public List<NoticeReply> getAllReply(int boardNo) throws Exception;

	public int viewCountIncrese(int no) throws Exception;
	
	public Timestamp pageViewCheck(String ipaddr, int noticeNo) throws Exception;

	public int insertAccessDate(String ipaddr, int no) throws Exception;

	public int deleteReply(int replyNo) throws Exception;

	public int replyCountIncrese(int boardNo) throws Exception;

	public NoticeReply getBoardNoByReplyNo(int replyNo) throws Exception;

	public int replyCountDecrease(int no) throws Exception;

	public int updateReply(NoticeReply nr) throws Exception;

	public int getMaxReplyNo() throws Exception;

	public int updateAccessDate(String ipaddr, int noticeNo) throws Exception;

	
}
