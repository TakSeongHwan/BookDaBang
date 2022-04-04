package com.bookdabang.lhs.persistence;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.Notice;
import com.bookdabang.common.domain.NoticeReply;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.NoticeMapper";

	@Override
	public List<Notice> entireNotice() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".getEntireNotice");
	}

	@Override
	public Notice getContentByNo(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+ ".readNotice",no);
	}

	@Override
	public int getNoticeNo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getMaxNo");
	}

	@Override
	public int insertNotice(Notice n) throws Exception {
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
	public int insertReply(NoticeReply reply) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns+".insertReply",reply);
	}

	@Override
	public List<NoticeReply> getAllReply(int boardNo) throws Exception {
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
	public NoticeReply getBoardNoByReplyNo(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".getReplyInfoByReplyNo",no);
	}

	@Override
	public int replyCountDecrease(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns+".replyCountDecrease",no);
	}

	@Override
	public int updateReply(NoticeReply nr) throws Exception {
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


}
