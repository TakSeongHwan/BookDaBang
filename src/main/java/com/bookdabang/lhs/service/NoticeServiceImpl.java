package com.bookdabang.lhs.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.NoticeReplyVO;
import com.bookdabang.lhs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Inject 
	NoticeDAO noticeDAO;

	@Override
	public List<NoticeVO> entireNotice(int pageNo) throws Exception {
		System.out.println(pageNo);
		return noticeDAO.entireNotice();
	}

	@Override
	public NoticeVO getContentByNo(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getContentByNo(no);
	}

	@Override
	public int getNoticeNo() throws Exception {
		
		return noticeDAO.getNoticeNo();
	}

	@Override
	public int insertNotice(NoticeVO n) throws Exception {
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
	public int insertReply(NoticeReplyVO reply) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.insertReply(reply);
	}

	@Override
	public List<NoticeReplyVO> getAllReply(int boardNo) throws Exception {
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
	public NoticeReplyVO getBoardNoByReplyNo(int replyNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getBoardNoByReplyNo(replyNo);
	}

	@Override
	public int replyCountDecrease(int no) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.replyCountDecrease(no);
	}

	@Override
	public int updateReply(NoticeReplyVO nr) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.updateReply(nr);
	}

	@Override
	public int getMaxReplyNo() throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getMaxReplyNo();
	}

	@Override
	public int updateAccessDate(String ipaddr, int noticeNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.updateAccessDate(ipaddr, noticeNo);
	}

	@Override
	public int updateNewImageFile(String newImage, int noticeNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.updateNewImageFile(newImage, noticeNo);
	}


	@Override
	public int getAfByNoImgFn(String fn) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getAfByNoImgFn(fn);
	}

	@Override
	public int getAfByThumbFn(String fn) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.getAfByThumbFn(fn);
	}

	@Override
	public int deleteOldAttachFile(int attachFileNo) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.deleteOldAttachFile(attachFileNo);
	}

	@Override
	public int updateNoticeText(NoticeVO n) throws Exception {
		// TODO Auto-generated method stub
		return noticeDAO.updateNoticeText(n);
	}

	@Override
	public boolean updateNoticeAndAttach(NoticeVO n, List<AttachFileVO> fileName) throws Exception {
		boolean result = false;
		
		
		
		
		
		return result;
	}

	
}
