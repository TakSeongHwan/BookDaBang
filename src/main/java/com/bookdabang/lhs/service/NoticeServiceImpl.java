package com.bookdabang.lhs.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.NoticeReplyVO;
import com.bookdabang.lhs.etc.ImageFileHandling;
import com.bookdabang.lhs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Inject 
	NoticeDAO noticeDAO;

	
	@Override
	public Map<String,Object> entireNotice(int pageNo, BoardSearch bs) throws Exception {
		System.out.println(pageNo);
		
		PagingInfo pi = pagingProcess(pageNo, bs);
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		System.out.println(bs.toString());
	
			if(bs.getSearchWord().equals("") || bs.getSearchType().equals("")) {
				list = noticeDAO.entireNotice(pi);
			}else {
				list = noticeDAO.entireNotice(pi,bs);
			}

		Map<String,Object> map = new HashMap<String, Object>();
		map.put("notice", list);
		map.put("pagingInfo", pi);
		return map;
	}
	
	private PagingInfo pagingProcess(int pageNo, BoardSearch bs) {
		PagingInfo pi = new PagingInfo();
		System.out.println("페이지 프로세스 : "+bs);
		try{
			if(bs.getSearchWord().equals("") || bs.getSearchType().equals("")) {
				int cnt = noticeDAO.getTotalPost();
				pi.setTotalPostCnt(noticeDAO.getTotalPost());
				System.out.println("검색결과 갯수 : "+cnt);
			}else {
				int cnt = noticeDAO.getSearchResultCnt(bs);
				System.out.println("검색결과 갯수 : "+cnt);
				pi.setTotalPostCnt(noticeDAO.getSearchResultCnt(bs));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		pi.setTotalPage(pi.getTotalPostCnt());
		
		pi.setStartNum(pageNo);
		
		pi.setTotalPagingBlock(pi.getTotalPage());
		
		pi.setCurrentPagingBlock(pageNo);
		
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());
		
		System.out.println(pi.toString());
		return pi;
	
	}

	@Override
	@Transactional
	public NoticeVO getContentByNo(String ipaddr, int no) throws Exception {
		
		Timestamp lastAccessTime = noticeDAO.pageViewCheck(ipaddr, no);
		
		if(lastAccessTime != null) {
			
			long lastAccessDate = lastAccessTime.getTime();
			long currTime = System.currentTimeMillis();
			
			if(currTime - lastAccessDate > 1000 * 60 *60*24) {
				if(noticeDAO.updateAccessDate(ipaddr, no) == 1) {
					noticeDAO.viewCountIncrese(no);
					System.out.println("조회수 올라감");
				}
			}else {
				System.out.println("조회수 안올라감");
			}
		}else {
			if(noticeDAO.insertAccessDate(ipaddr, no) == 1) {
				noticeDAO.viewCountIncrese(no);
				System.out.println("조회수 올라감");
			}
			
		}

		return noticeDAO.getContentByNo(no);
	}
	
	public NoticeVO getContentByNo(int no) throws Exception {

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
	@Transactional
	public int deleteNotice(int no, String upPathImg, String upPathAttach) throws Exception {
		int result = 0;
		
		NoticeVO nv = noticeDAO.getContentByNo(no);
		String imgName = nv.getImage();
		
		ImageFileHandling ifh = new ImageFileHandling();
		List<AttachFileVO> aList = noticeDAO.getAttachFile(no);

		
		if(noticeDAO.deleteNotice(no) == 1) {
			
			ifh.fileDelete(upPathImg, imgName);
			
			for(AttachFileVO af : aList) {
				if(af.getNotImageFile() != null) {
					String originFile = af.getOriginFile();
					ifh.fileDelete(upPathAttach, originFile);
					
					
				}else if(af.getThumbnailFile() != null) {
					String originFile = af.getOriginFile();
					String thumbFile = af.getThumbnailFile();
					ifh.fileDelete(upPathAttach, originFile);
					ifh.fileDelete(upPathAttach, thumbFile);
				}
			}
			result = 1;
		}

		return result;
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
