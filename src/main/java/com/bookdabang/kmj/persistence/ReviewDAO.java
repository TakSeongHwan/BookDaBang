package com.bookdabang.kmj.persistence;

import java.util.List;

import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.kmj.domain.ReviewStatisticsVO;
import com.bookdabang.kmj.domain.SearchInfoDTO;
import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReviewComment;

public interface ReviewDAO {
	// n번 상품의 리뷰들 가져오는 메서드 (페이징 포함)
	public List<ReviewVO> selectAllReview (int prodNo,PagingInfo pi,int sort) throws Exception;
	
	// n번 리뷰의 댓글들 가져오는 메서드
	public List<ReviewComment> selectAllComments(int reviewNo) throws Exception;
	
	// 관리자 - n번 리뷰의 댓글들 가져오는 메서드 (페이징 포함)
	public List<ReviewComment> selectAllComments(int reviewNo,PagingInfo pi) throws Exception;
	
	// 다음 댓글 번호 가져오는 메서드
	public int selectNextRef() throws Exception;
	
	// n번 리뷰의 댓글 추가하는 메서드
	public int insertComment(ReviewComment comment) throws Exception;
	
	// n번 리뷰의 댓글 수 추가하는 메서드
	public int updateCommentNum (int reviewNo) throws Exception;
	
	// 최신순 정렬 위해 이전 답글 변경하는 메서드
	public int updatePrevReply (ReviewComment comment) throws Exception;
	
	// 답글 추가하는 메서드
	public int insertReply (ReviewComment comment) throws Exception;
	
	// n번 리뷰를 추천한 유저인지 확인하는 메서드
	public List<Integer> selectRecommend(String userId) throws Exception;
	
	// n번 리뷰의 추천수 바꿔주는 메서드 
	public int updateRecommend(RecommendVO recommend) throws Exception;
	
	// 추천 테이블에 추가하는 메서드 
	public int insertRecommend(RecommendVO recommend) throws Exception;
	
	// 추천 테이블에서 삭제하는 메서드
	public int deleteRecommend(RecommendVO recommend) throws Exception;
	
	// 리뷰 추가하는 메서드
	public int insertReview(ReviewVO review) throws Exception;
	
	// 리뷰 수정하는 메서드
	public int updateReview(ReviewVO review) throws Exception;
	
	// 리뷰 삭제하는 메서드
	public int deleteReview(int reviewNo) throws Exception;
	
	// 댓글 수정하는 메서드
	public int updateComment(ReviewComment comment) throws Exception;
	
	// 댓글 삭제하는 메서드
	public int deleteComment(int cno) throws Exception;
	
	// n번 리뷰의 추천수 바꿔주는 메서드
	public int updateCommentNum2(int reviewNo) throws Exception;
	
	// 다음 리뷰 번호 가져오는 메서드
	public int selectReviewNo() throws Exception;
	
	// 첨부파일 추가하는 메서드
	public int insertAttachFile(AttachFileVO attachFileVO) throws Exception;
	
	// 첨부파일 모두 가져오는 메서드
	public List<AttachFileVO> selectAllAttachFile(int prodNo) throws Exception;
	
	// 해당 리뷰에 첨부파일 있는 지 확인하는 메서드
	public List<AttachFileVO> selectAttachFileByRNo(int reviewNo) throws Exception;
	
	// 리뷰 수정시, 기존 첨부파일 삭제하는 메서드
	public int deleteAttachFile(int attachFileNo) throws Exception;
	
	// 해당 상품의 리뷰 전체개수 가져오는 메서드
	public int getReviewTotalPost(int prodNo) throws Exception;
	
	// 관리자 - 리뷰 검색 결과의 총 개수 가져오는 메서드
	public int getReviewSearchTotalPost(SearchInfoDTO searchInfo) throws Exception;
	
	// 관리자 - 리뷰댓글 총 개수 가져오는 메서드
	public int getCommentTotalPost(int reviewNo) throws Exception;
	
	// 관리자 - 리뷰 검색 결과 가져오는 메서드
	public List<ReviewVO> selectSearchReview(SearchInfoDTO searchInfo, PagingInfo pi) throws Exception;
	
	// 관리자 - 리뷰 상세정보 가져오는 메서드
	public ReviewVO selectReview(int reviewNo) throws Exception;
	
	// 리뷰 통계자료 가져오는 메서드
	public ReviewStatisticsVO selectReviewStatistics(int prodNo) throws Exception;
	
}
