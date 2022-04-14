package com.bookdabang.lhs.persistence;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.NoticeReplyVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.NoticeMapper";

	@Override
	public List<NoticeVO> entireNotice(PagingInfo pi) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".getEntireNotice", pi);
	}
	public List<NoticeVO> entireNotice(PagingInfo pi, BoardSearch bs) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", bs.getSearchType());
		map.put("searchWord", bs.getSearchWord());
		map.put("startNum", pi.getStartNum());
		map.put("postPerPage", pi.getPostPerPage());
		
		System.out.println(map.toString());
		System.out.println(bs.toString());
		
		return ses.selectList(ns + ".getSearchResultList", map);
	}

	@Override
	public NoticeVO getContentByNo(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+ ".readNotice",no);
	}

	@Override
	public int getNoticeNo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getMaxNo");
	}

	@Override
	public int insertNotice(NoticeVO n) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("no", n.getNo());
		map.put("title", n.getTitle());
		map.put("writer", n.getWriter());
		map.put("content", n.getContent());
		map.put("image", n.getImage());
		
		return ses.insert(ns + ".insertNotice", map);
	}

	@Override
	public int insertAttachFile(AttachFileVO file, int no) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
			map.put("noticeNo", no);
			map.put("originF‎ile", file.getOriginFile());
			map.put("thumbnailFile", file.getThumbnailFile());
			map.put("notImageFile", file.getNotImageFile());
		
		
	

		return ses.insert(ns+".insertAttachFile", map);
	}

	@Override
	public List<AttachFileVO> getAttachFile(int noticeNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getAttachFile",noticeNo);
	}

	@Override
	public int deleteNotice(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns+".deleteNotice",no);
	}

	@Override
	public int insertReply(NoticeReplyVO reply) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns+".insertReply",reply);
	}

	@Override
	public List<NoticeReplyVO> getAllReply(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getReply",boardNo);
	}

	@Override
	public int viewCountIncrese(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns+".viewCountIncrese", no);
	}

	@Override
	public Timestamp pageViewCheck(String ipaddr, int noticeNo) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ip_address", ipaddr);
		map.put("noticeNo",noticeNo);
		return ses.selectOne(ns+".pageViewCheck",map);
	}

	@Override
	public int insertAccessDate(String ipaddr, int no) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ip_address", ipaddr);
		map.put("noticeNo",no);
		return ses.insert(ns+".insertAccessDate",map);
	}

	@Override
	public int deleteReply(int replyNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns+".deleteReply",replyNo);
	}

	@Override
	public int replyCountIncrese(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns+".replyCountIncrese",no);
	}

	@Override
	public NoticeReplyVO getBoardNoByReplyNo(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getReplyInfoByReplyNo",no);
	}

	@Override
	public int replyCountDecrease(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns+".replyCountDecrease",no);
	}

	@Override
	public int updateReply(NoticeReplyVO nr) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", nr.getBoardNo());
		map.put("replyNo", nr.getReplyNo());
		map.put("replyer", nr.getReplyer());
		map.put("replyContent", nr.getReplyContent());
		
		return ses.update(ns+".updateReply",map);
	}

	@Override
	public int getMaxReplyNo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getMaxReplyNo");
	}

	@Override
	public int updateAccessDate(String ipaddr, int noticeNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ip_address", ipaddr);
		map.put("noticeNo",noticeNo);
		return ses.update(ns+".updateAccessDate", map);
	}

	@Override
	public int updateNewImageFile(String newImage, int noticeNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("image", newImage);
		map.put("no",noticeNo);
		return ses.update(ns+".updateNewImageFile", map);
	}

	@Override
	public int getAfByNoImgFn(String notImageFile) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".selectAfByNoImgFn",notImageFile);
	}

	@Override
	public int getAfByThumbFn(String thumbnailFile) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".selectAfByThumbFn",thumbnailFile);
	}

	@Override
	public int deleteOldAttachFile(int attachFileNo) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns+".deleteOldAttachFile",attachFileNo);
	}

	@Override
	public int updateNoticeText(NoticeVO n) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns+".updateNoticeText",n);
	}
	@Override
	public int getTotalPost() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getTotalPost");
	}
	@Override
	public int getSearchResultCnt(BoardSearch bs) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getSearchResultCnt",bs);
	}


}
