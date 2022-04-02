package com.bookdabang.lhs.service;

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
}
