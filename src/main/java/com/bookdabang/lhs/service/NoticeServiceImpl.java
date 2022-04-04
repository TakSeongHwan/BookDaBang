package com.bookdabang.lhs.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.Notice;
import com.bookdabang.common.domain.NoticeReply;
import com.bookdabang.lhs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Inject 
	NoticeDAO noticeDAO;

	@Override
	public List<Notice> entireNotice() throws Exception {
		return noticeDAO.entireNotice();
	}

	@Override
	public Notice getContentByNo(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getContentByNo(no);
	}

	@Override
	public int getNoticeNo() throws Exception {
		
		return noticeDAO.getNoticeNo();
	}

	@Override
	public int insertNotice(Notice n) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.insertNotice(n);
	}

	@Override
	public int insertAttachFile(AttachFileVO file, int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.insertAttachFile(file, no);
	}

	@Override
	public List<AttachFileVO>  getAttachFile(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getAttachFile(no);
	}

	@Override
	public int deleteNotice(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.deleteNotice(no);
	}

	@Override
	public int insertReply(NoticeReply reply) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.insertReply(reply);
	}

	@Override
	public List<NoticeReply> getAllReply(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getAllReply(boardNo);
	}

	@Override
	public int viewCountIncrese(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.viewCountIncrese(no);
	}

	@Override
	public Timestamp pageViewCheck(String ipaddr, int noticeNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.pageViewCheck(ipaddr, noticeNo);
	}

	@Override
	public int insertAccessDate(String ipaddr, int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.insertAccessDate(ipaddr,no);
	}

	@Override
	public int deleteReply(int replyNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.deleteReply(replyNo);
	}

	@Override
	public int replyCountIncrese(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.replyCountIncrese(boardNo);
	}

	@Override
	public NoticeReply getBoardNoByReplyNo(int replyNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getBoardNoByReplyNo(replyNo);
	}

	@Override
	public int replyCountDecrease(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.replyCountDecrease(no);
	}

	@Override
	public int updateReply(NoticeReply nr) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.updateReply(nr);
	}

	@Override
	public int getMaxReplyNo() throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getMaxReplyNo();
	}

	
}
