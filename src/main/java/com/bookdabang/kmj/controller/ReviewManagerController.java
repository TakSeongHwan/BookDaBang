package com.bookdabang.kmj.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.kmj.domain.SearchInfoDTO;
import com.bookdabang.kmj.service.ReviewService;

@Controller 
@RequestMapping("/reviewManager")
public class ReviewManagerController {
	
	@Inject
	private ReviewService rService;
	
	@RequestMapping(value = "/listReview", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> searchReview(@RequestBody SearchInfoDTO searchInfo) {
		System.out.println("(관리자) 리뷰 리스트 " + searchInfo.getPageNo() + "페이지 - " + searchInfo.toString());
		ResponseEntity<Map<String, Object>> result = null;
		
		try {
			Map<String, Object> map = rService.searchReview(searchInfo);
			//map = rService.readAllReview(0,searchInfo.getPageNo());
			result = new ResponseEntity<Map<String, Object>> (map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}
	
	@RequestMapping(value = "/deleteReview", method = RequestMethod.POST)
	public ResponseEntity<String> deleteReview(@RequestParam("deleteNoList[]") List<Integer> deleteNoList,
			@RequestParam("deleteFileList[]") List<String> deleteFileList, HttpServletRequest request) {
		System.out.println("(관리자) 리뷰리스트 리뷰삭제 번호리스트 - " + deleteNoList);
		System.out.println("(관리자) 리뷰리스트 리뷰삭제 파일리스트 - " + deleteFileList);
		ResponseEntity<String> result = null;
		boolean DBResult = false;
		boolean oFile = false, tFile = false;
		boolean delFileResult = false;
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		
		try {
			DBResult = rService.deleteReviews(deleteNoList);
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		if (DBResult) {
			if (deleteFileList.contains("파일없음")) {
				delFileResult = true;
			} else {
				for (String fileName : deleteFileList) {
					if (fileName.contains("thumb")) {
						File delFile = new File(upPath + fileName.replace("/", File.separator));
						tFile = delFile.delete();
						String originalFileName = fileName.replace("thumb_", "");
						File originFile = new File(upPath + originalFileName.replace("/", File.separator));
						oFile = originFile.delete();
					} else {
						File delFile = new File(upPath + fileName.replace("/", File.separator));
						oFile = delFile.delete();
						if (oFile) {
							tFile = true;
						}
					}
					
					if (oFile && tFile) {
						delFileResult = true;
						System.out.println("(관리자 리뷰삭제) 파일명 : " + fileName + " - 삭제 완료(" + oFile  + "/" + tFile + ")");
					} else {
						delFileResult = false;
						System.out.println("(관리자 리뷰삭제) 파일명 : " + fileName + " - 삭제 실패(" + oFile  + "/" + tFile + ")");
						result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
						break;
					}
				}
			}
		} 
		
		if (delFileResult) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/detailComment", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getComment(@RequestParam("no") int reviewNo,@RequestParam("pageNo") int pageNo) {
		System.out.println("(관리자) 상세페이지 리뷰번호 : " + reviewNo + "번 - " + pageNo + " 페이지");
		ResponseEntity<Map<String, Object>> result = null;
		
		try {
			Map<String, Object> map = rService.readAllComments(reviewNo,pageNo);
			result = new ResponseEntity<Map<String, Object>> (map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}
	
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public ResponseEntity<String> deleteComment(@RequestParam("deleteNoList[]") List<Integer> deleteNoList,
			@RequestParam("reviewNo") int reviewNo) {
		System.out.println("(관리자) 상세페이지 리뷰 " + reviewNo + "번 댓글삭제 번호리스트 - " + deleteNoList);
		ResponseEntity<String> result = null;
		
		try {
			if (rService.deleteComments(deleteNoList,reviewNo)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return result;
	}
}
