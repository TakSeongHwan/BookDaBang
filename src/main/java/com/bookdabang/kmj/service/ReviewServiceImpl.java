package com.bookdabang.kmj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.common.domain.ReviewComment;
import com.bookdabang.kmj.domain.ReviewStatisticsVO;
import com.bookdabang.kmj.domain.SearchInfoDTO;
import com.bookdabang.kmj.etc.UploadFile;
import com.bookdabang.kmj.persistence.ReviewDAO;
import com.bookdabang.ljs.persistence.LoginDAO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewDAO rDao;
	
	@Inject
	private LoginDAO lDao;
	
	@Override
	public Map<String, Object> readAllReview(int prodNo,int pageNo,int sort) throws Exception {
		System.out.println(prodNo);
		PagingInfo pi = pagingProcess(prodNo,pageNo,null,0);
		
		List<ReviewVO> lst = rDao.selectAllReview(prodNo,pi,sort);
		List<AttachFileVO> lst2 = rDao.selectAllAttachFile(prodNo);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("reviewList", lst);
		resultMap.put("pagingInfo", pi);
		resultMap.put("fileList", lst2);
		
		return resultMap;
	}
	
	// 페이징 처리 작업 전담 메서드
	private PagingInfo pagingProcess(int prodNo,int pageNo,SearchInfoDTO searchInfo,int reviewNo) throws Exception {
		PagingInfo pi = new PagingInfo();
		
		if (searchInfo == null) {
			if (reviewNo == 0) {
				// 1페이지당 보여 줄 글의 개수 & 1개의 블럭에 보여줄 페이지 수
				pi.setPostPerPage(5);
				pi.setPageCntPerBlock(3);
				// 전체 게시물 개수
				pi.setTotalPostCnt(rDao.getReviewTotalPost(prodNo));
			} else {
				// 1페이지당 보여 줄 글의 개수 & 1개의 블럭에 보여줄 페이지 수
				pi.setPostPerPage(10);
				pi.setPageCntPerBlock(3);
				// 전체 게시물 개수
				pi.setTotalPostCnt(rDao.getCommentTotalPost(reviewNo));
			}
		} else {
			// 1페이지당 보여 줄 글의 개수 & 1개의 블럭에 보여줄 페이지 수
			pi.setPostPerPage(10);
			pi.setPageCntPerBlock(5);
			// 전체 게시물 개수
			pi.setTotalPostCnt(rDao.getReviewSearchTotalPost(searchInfo));
		}

		// 전체 페이지 수
		pi.setTotalPage(pi.getTotalPostCnt());
		// 현재 페이지에서 출력 시작할 글번호
		pi.setStartNum(pageNo);
		// 전체 페이징 블럭
		pi.setTotalPagingBlock(pi.getTotalPage());
		// 현재 페이징 블럭
		pi.setCurrentPagingBlock(pageNo);
		// 현재 페이지에서의 시작 페이징블럭
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		// 현재 페이지에서의 끝 페이징블럭
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());

		System.out.println(pi.toString());

		return pi;
	}

	@Override
	public List<ReviewComment> readAllComments(int rno) throws Exception {
		List<ReviewComment> lst = rDao.selectAllComments(rno);
		return lst;
	}
	
	@Override
	public Map<String, Object> readAllComments(int reviewNo, int pageNo) throws Exception {
		PagingInfo pi = pagingProcess(0,pageNo,null,reviewNo);
		List<ReviewComment> lst = rDao.selectAllComments(reviewNo,pi);
		
		System.out.println(lst);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("commentList", lst);
		resultMap.put("pagingInfo", pi);
		return resultMap;
	}

	@Override
	public boolean addComment(ReviewComment comment) throws Exception {
		// 세션아이디를 유저아이디로 변환
		MemberVO member = lDao.findLoginSess(comment.getCommenter());
		comment.setCommenter(member.getUserId());
		
		boolean result = false;
		
		if (comment.getRef() == 0) {
			// 다음 답글 번호 가져와 ref 설정
			comment.setRef(rDao.selectNextRef());
			
			// 리뷰 댓글 개수 업데이트 후 댓글 추가
			if (rDao.updateCommentNum(comment.getReviewNo()) == 1) {
				if(rDao.insertComment(comment) == 1) {
					result = true;
				}
			}
			
		} else {
			// 답글 깊이(레벨)가 같은 글에 대해 최신 답글이 더 위로 올라오도록 정렬 (이전 답글이 있을 때 바뀜
			rDao.updatePrevReply(comment);
			if (rDao.updateCommentNum(comment.getReviewNo()) == 1) {
				if (rDao.insertReply(comment) == 1) {
					result = true;
				}
			}	
		}
		
		return result;
	}
	
	@Override
	public List<Integer> confirmRecommend(String userId) throws Exception {
		List<Integer> result = null;
		
		if (rDao.selectRecommend(userId) != null) {
			result = rDao.selectRecommend(userId);
		}
		
		return result;
	}

	@Override
	public boolean changeRecommend (RecommendVO recommend) throws Exception {
		boolean result = false;
		
		if (rDao.updateRecommend(recommend) == 1 ) {
			if (recommend.getChange() == 1) {
				if (rDao.insertRecommend(recommend) == 1) {
					result = true;
				}
			} else if (recommend.getChange() == 2) {
				if (rDao.deleteRecommend(recommend) == 1) {
					result = true;
				}
			}
		}
		
		return result;
	}

	@Override
	public boolean addReview(ReviewVO review,List<UploadFile> upfileList) throws Exception {
		// 세션아이디를 유저아이디로 변환
		MemberVO member = lDao.findLoginSess(review.getWriter());
		review.setWriter(member.getUserId());
				
		boolean result = false;
		
		if (rDao.insertReview(review) == 1) {
			result = true;
		}
		
		int reviewNo = rDao.selectReviewNo();
		for (UploadFile file : upfileList) {
			if (rDao.insertAttachFile(new AttachFileVO(reviewNo,review.getProductNo(),file.getOriginalFileName(),
					file.getThumbnailFileName(), file.getNotImageFileName())) != 1) {
				result = false;
			}
		}
		
		return result;
	}

	@Override
	public boolean modifyReview(ReviewVO review,List<UploadFile> upfileList) throws Exception {
		boolean result = false;
		boolean fileResult = true;
		boolean reviewResult = false;
		
		for (UploadFile file : upfileList) {
			if (rDao.insertAttachFile(new AttachFileVO(review.getReviewNo(),review.getProductNo(),file.getOriginalFileName(),
					file.getThumbnailFileName(), file.getNotImageFileName())) != 1) {
				fileResult = false;
			}
		}
		
		System.out.println(rDao.selectAttachFileByRNo(review.getReviewNo()).toString());
		
		if (rDao.selectAttachFileByRNo(review.getReviewNo()).size() < 1) {
			review.setFileStatus("no");
		} else {
			review.setFileStatus("yes");
		}
		
		if (rDao.updateReview(review) == 1) {
			reviewResult = true;
		}
		
		if (fileResult && reviewResult) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean deleteReview(int reviewNo) throws Exception {
		boolean result = false;
		
		if (rDao.deleteReview(reviewNo) == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean modifyComment(ReviewComment comment) throws Exception {
		boolean result = false;
		
		if (rDao.updateComment(comment) == 1) {
			result = true;
		}
	
		return result;
	}

	@Override
	public boolean deleteComment(ReviewComment comment) throws Exception {
		boolean result = false;
		
		if (rDao.updateCommentNum2(comment.getReviewNo()) == 1) {
			if (rDao.deleteComment(comment.getCommentNo()) == 1) {
				result = true;
			}
		}
		
		return result;
	}

	@Override
	public boolean deleteAttachFile(List<Integer> attachNoList) throws Exception {
		boolean result = false;
		
		for (int attachFileNo : attachNoList) {
			if (rDao.deleteAttachFile(attachFileNo) == 1) {
				result = true;
			}
		}

		return result;
	}

	@Override
	public Map<String, Object> searchReview(SearchInfoDTO searchInfo) throws Exception {
		PagingInfo pi = pagingProcess(0,searchInfo.getPageNo(),searchInfo,0);
		
		List<ReviewVO> lst = rDao.selectSearchReview(searchInfo,pi);
		List<AttachFileVO> lst2 = null;
		if (searchInfo.getFileStatus() != "no") {
			lst2 = rDao.selectAllAttachFile(0);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("reviewList", lst);
		resultMap.put("pagingInfo", pi);
		resultMap.put("fileList", lst2);
		
		return resultMap;
		
	}

	@Override
	public Map<String, Object> readReview(int reviewNo) throws Exception {
		ReviewVO review = rDao.selectReview(reviewNo);
		List<AttachFileVO> fileList = null;
		
		if (review.getFileStatus().equals("yes")) {
			fileList = rDao.selectAttachFileByRNo(reviewNo);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("review", review);
		resultMap.put("fileList", fileList);
		
		return resultMap;
	}

	@Override
	public boolean deleteReviews(List<Integer> deleteNoList) throws Exception {
		boolean result = false;
		
		for (Integer reviewNo : deleteNoList) {
			if (rDao.deleteReview(reviewNo) == 1) {
				result = true;
			} else {
				result = false;
				break;
			}
		}
		
		return result;
	}

	@Override
	public boolean deleteComments(List<Integer> deleteNoList, int reviewNo) throws Exception {
		boolean result = false;
		
		for (Integer commentNo : deleteNoList) {
			if (rDao.deleteComment(commentNo) == 1) {
				if (rDao.updateCommentNum2(reviewNo) == 1) {
					result = true;
				}
			} else {
				result = false;
				break;
			}	
		}
		
		return result;
	}

	@Override
	public ReviewStatisticsVO getReviewStatistics(int prodNo) throws Exception {
		ReviewStatisticsVO reviewStatistics = rDao.selectReviewStatistics(prodNo);
		return reviewStatistics;
	}
	

}
