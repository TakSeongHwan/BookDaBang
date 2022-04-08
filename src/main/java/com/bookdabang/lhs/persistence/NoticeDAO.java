package com.bookdabang.lhs.persistence;

import java.sql.Timestamp;
import java.util.List;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.NoticeReplyVO;

public interface NoticeDAO {
	public List<NoticeVO> entireNotice() throws Exception;
	
	public NoticeVO getContentByNo(int no) throws Exception;
	
	public int getNoticeNo() throws Exception;
	
	public int insertNotice(NoticeVO n) throws Exception;
	
	public int insertAttachFile(AttachFileVO file, int no) throws Exception;
	
	public List<AttachFileVO>  getAttachFile(int no) throws Exception;
	
	public int deleteNotice(int no) throws Exception;
	
	public int insertReply(NoticeReplyVO reply) throws Exception;
	
	public List<NoticeReplyVO> getAllReply(int boardNo) throws Exception;
	
	public int viewCountIncrese(int no) throws Exception;
	
	public Timestamp pageViewCheck(String ipaddr, int noticeNo) throws Exception;
	
	public int insertAccessDate(String ipaddr, int no) throws Exception;
	
	public int deleteReply(int replyNo) throws Exception;
	
	public int replyCountIncrese(int boardNo) throws Exception;
	
	public NoticeReplyVO getBoardNoByReplyNo(int replyNo) throws Exception;
	
	public int replyCountDecrease(int no) throws Exception;
	
	public int updateReply(NoticeReplyVO nr) throws Exception;

	public int getMaxReplyNo() throws Exception;

	public int updateAccessDate(String ipaddr, int noticeNo) throws Exception;

	public int updateNewImageFile(String newImage, int noticeNo) throws Exception;

	public int getAfByNoImgFn(String fn) throws Exception;

	public int getAfByThumbFn(String fn) throws Exception;

	public int deleteOldAttachFile(int attachFileNo) throws Exception;

	public int updateNoticeText(NoticeVO n) throws Exception;


	
}
