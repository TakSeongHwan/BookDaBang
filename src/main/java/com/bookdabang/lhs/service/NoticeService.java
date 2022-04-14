package com.bookdabang.lhs.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.NoticeReplyVO;

public interface NoticeService {

	//공지사항 전체조회
	public Map<String,Object> entireNotice(int pageNo, BoardSearch bs) throws Exception;
	
	//no번 공지사항 조회
	public NoticeVO getContentByNo(String ipaddr, int no) throws Exception;
	
	public NoticeVO getContentByNo(int no) throws Exception;
	
	//공지사항번호 최대값 가져오기 
	public int getNoticeNo() throws Exception;
	
	//공지사항 등록하기
	public int insertNotice(NoticeVO n) throws Exception;

	//공지사항 첨부파일 등록하기
	public int insertAttachFile(AttachFileVO file, int no) throws Exception;
	
	//첨부파일 불러오기
	public List<AttachFileVO> getAttachFile(int no) throws Exception;

	//공지사항 삭제하기
	public int deleteNotice(int no, String upPathImg, String upPathAttach) throws Exception;

	//댓글 등록하기
	public int insertReply(NoticeReplyVO reply) throws Exception;

	//댓글 조회하기
	public List<NoticeReplyVO> getAllReply(int boardNo) throws Exception;

	//조회수 증가
	public int viewCountIncrese(int no) throws Exception;
	
	//공지사항 열람시간 가져오기
	public Timestamp pageViewCheck(String ipaddr, int noticeNo) throws Exception;

	//공지사항 열람시간 입력하기
	public int insertAccessDate(String ipaddr, int no) throws Exception;

	//댓글 지우기
	public int deleteReply(int replyNo) throws Exception;

	//댓글수 증가
	public int replyCountIncrese(int boardNo) throws Exception;

	//댓글번호로 댓글정보 가져오기
	public NoticeReplyVO getBoardNoByReplyNo(int replyNo) throws Exception;

	//댓글수 감소
	public int replyCountDecrease(int no) throws Exception;

	//댓글 수정
	public int updateReply(NoticeReplyVO nr) throws Exception;

	//댓글번호 최대값 가져오기
	public int getMaxReplyNo() throws Exception;

	//공지사항 열람시간 업데이트하기
	public int updateAccessDate(String ipaddr, int noticeNo) throws Exception;

	//공지사항 수정시 새로운 이미지파일이 있다면 업데이트
	public int updateNewImageFile(String newImage, int noticeNo) throws Exception;

	//이미지가 아닌 첨부파일 이름으로 첨부파일번호 가져오기
	public int getAfByNoImgFn(String fn) throws Exception;

	//이미지인 첨부파일 이름으로 첨부파일 번호 가져오기
	public int getAfByThumbFn(String fn) throws Exception;

	//첨부파일 삭제
	public int deleteOldAttachFile(int attachFileNo) throws Exception;

	//파일종류를 제외한 공지사항정보 수정
	public int updateNoticeText(NoticeVO n) throws Exception;
	
	public boolean updateNoticeAndAttach(NoticeVO n, List<AttachFileVO> fileName) throws Exception;

	
	
	
	
	
	
}
