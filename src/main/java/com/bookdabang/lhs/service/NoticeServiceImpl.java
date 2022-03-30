package com.bookdabang.lhs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.Notice;
import com.bookdabang.lhs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Inject 
	NoticeDAO noticeDAO;

	@Override
	public List<Notice> entireNotice() {
		return noticeDAO.entireNotice();
	}

	@Override
	public Notice getContentByNo(int no) {
		// TODO Auto-generated method stub
		return noticeDAO.getContentByNo(no);
	}

	@Override
	public int getNoticeNo() {
		
		return noticeDAO.getNoticeNo();
	}

	@Override
	public int insertNotice(Notice n) {
		// TODO Auto-generated method stub
		return noticeDAO.insertNotice(n);
	}

	@Override
	public int insertAttachFile(AttachFileVO file, int no) {
		// TODO Auto-generated method stub
		return noticeDAO.insertAttachFile(file, no);
	}
}
