package com.bookdabang.lhs.service;

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
}
