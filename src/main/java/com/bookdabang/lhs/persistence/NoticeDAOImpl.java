package com.bookdabang.lhs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.Notice;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.NoticeMapper";

	@Override
	public List<Notice> entireNotice() {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".getEntireNotice");
	}

	@Override
	public Notice getContentByNo(int no) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+ ".readNotice",no);
	}

	@Override
	public int getNoticeNo() {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getMaxNo");
	}

	@Override
	public int insertNotice(Notice n) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("no", n.getNo());
		map.put("title", n.getTitle());
		map.put("writer", n.getWriter());
		map.put("content", n.getContent());
		map.put("image", n.getImage());
		
		return ses.insert(ns + ".insertNotice", map);
	}

	@Override
	public int insertAttachFile(AttachFileVO file, int no) {
		
		Map<String,Object> map = new HashMap<String, Object>();
			map.put("noticeNo", no);
			map.put("originF‎ile", file.getOriginFile());
			map.put("thumbnailFile", file.getThumbnailFile());
			map.put("notImageFile", file.getNotImageFile());
		
		
	

		return ses.insert(ns+".insertAttachFile", map);
	}
	
}
