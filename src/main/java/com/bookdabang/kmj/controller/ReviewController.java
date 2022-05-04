package com.bookdabang.kmj.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.kmj.etc.UploadFile;
import com.bookdabang.kmj.etc.UploadFileProcess;
import com.bookdabang.kmj.service.ReviewService;
import com.bookdabang.ljs.service.LoginService;

@Controller 
@RequestMapping("/review")
public class ReviewController {
	
	@Inject
	private ReviewService rService;
	
	@Inject
	private LoginService lService;
	
	private List<UploadFile> upfileList = new ArrayList<UploadFile>(); // 업로드된 파일들의 리스트
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> readReview(@RequestParam("no") int prodNo, @RequestParam("pageNo") int pageNo) {
		System.out.println(prodNo + "번 상품 " + pageNo + "페이지 리뷰 가져오기");
		ResponseEntity<Map<String, Object>> result = null;
		
		try {
			Map<String, Object> map = rService.readAllReview(prodNo,pageNo);
			result = new ResponseEntity<Map<String, Object>> (map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String addReview(ReviewVO review,RedirectAttributes rttr) throws Exception {
		System.out.println("리뷰 등록시작 - " + review.toString() + ", 첨부파일 : " + upfileList.toString());
		review.setContent(review.getContent().replace("\n", "<br/>"));
		
		if(upfileList.size() < 1) {
			review.setFileStatus("no");
		} else {
			review.setFileStatus("yes");
		}
		
		if (rService.addReview(review,this.upfileList)) {
			rttr.addFlashAttribute("addResult", "success");
		} else {
			rttr.addFlashAttribute("addResult", "fail");
		}
		
		this.upfileList.clear();
		return "redirect:/product/detail?no=" + review.getProductNo();
		
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modifyReview(ReviewVO review,RedirectAttributes rttr) throws Exception {
		System.out.println("리뷰 수정시작 - " + review.toString() + ", 추가 첨부파일 : " + upfileList.toString());
		review.setContent(review.getContent().replace("\n", "<br/>"));
		
		if (rService.modifyReview(review,this.upfileList)) {
			rttr.addFlashAttribute("modifyResult", "success");
		} else {
			rttr.addFlashAttribute("modifyResult", "fail");
		}
		
		this.upfileList.clear();
		return "redirect:/product/detail?no=" + review.getProductNo();
		
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String deleteReview(ReviewVO review,RedirectAttributes rttr) throws Exception {
		System.out.println("리뷰 삭제시작 - " + review.toString());
		
		if (rService.deleteReview(review.getReviewNo())) {
			rttr.addFlashAttribute("deleteResult", "success");
		} else {
			rttr.addFlashAttribute("deleteResult", "fail");
		}
		
		return "redirect:/product/detail?no=" + review.getProductNo();
	}
	
	@RequestMapping(value = "/showLike", method=RequestMethod.POST)
	public ResponseEntity<List<Integer>> readRecommend (@RequestBody RecommendVO recommend) {
		System.out.println(recommend.getUserId() + " 유저의 좋아요 가져오기");
		
		ResponseEntity<List<Integer>> result = null;
		
		try {
			List<Integer> lst = rService.confirmRecommend(recommend.getUserId());
			if(lst.size() < 1) {
				lst = null;
			}
			result = new ResponseEntity<List<Integer>>(lst, HttpStatus.OK);	
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);	
		}
		
		return result;
	}
	
	@RequestMapping(value = "/changeLike", method=RequestMethod.POST)
	public ResponseEntity<String> changeRecommend (@RequestBody RecommendVO recommend) {
		System.out.println("좋아요 추가/삭제 - " + recommend.toString() );
		
		ResponseEntity<String> result = null;
		
		try {
			if (rService.changeRecommend(recommend)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/{sessionId}", method = RequestMethod.GET,  produces = "application/text; charset=utf8")
	public ResponseEntity<String> getUserId(@PathVariable("sessionId") String sessionId) {
		System.out.println("세션아이디" + sessionId);
		ResponseEntity<String> result = null;
		
		try {
			String userId = (lService.findLoginSess(sessionId)).getUserId();
			result = new ResponseEntity<String>(userId, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}
	
	@RequestMapping(value = "/uploadFile", method=RequestMethod.POST)
	public ResponseEntity<UploadFile> uploadFile (MultipartFile upfile, HttpServletRequest request){
		System.out.println("업로드된 파일 이름 : " + upfile.getOriginalFilename());
		System.out.println("파일 사이즈  :" + upfile.getSize());
		System.out.println("업로드된 파일의 타입  :" + upfile.getContentType());
		System.out.println("파일 separator :" + File.separator);
		
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);
		
		UploadFile uploadFile = null;
		ResponseEntity<UploadFile> result = null;
		
		if(upfile.getSize() > 0 ) {
			UploadFileProcess ufp = new UploadFileProcess();
		
			try {
				uploadFile = ufp.uploadFileRename(upPath, upfile.getOriginalFilename(), upfile.getBytes());
				this.upfileList.add(uploadFile);
				result = new ResponseEntity<UploadFile>(uploadFile, HttpStatus.OK); 
			} catch (IOException e) {
				result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
				e.printStackTrace();
			}
		}
		
		System.out.println("(파일추가) 현재파일리스트 :" + this.upfileList.toString());
		return result;
	}
	
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public @ResponseBody String deleteFile(@RequestParam("targetFile") String targetFile, HttpServletRequest request) {
		System.out.println(targetFile + "파일 삭제");
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		boolean oFile = false, tFile = false;

		for (UploadFile file : this.upfileList) {
			if (file.getThumbnailFileName() != null) {
				if (file.getThumbnailFileName().equals(targetFile)) {
					File delFile = new File(upPath + targetFile.replace("/", File.separator));
					tFile = delFile.delete(); 
					File originFile = new File(upPath + file.getOriginalFileName().replace("/", File.separator));
					oFile = originFile.delete();
					this.upfileList.remove(file); 
					break;
				}
			}
			if (file.getNotImageFileName() != null) {
				if (file.getNotImageFileName().equals(targetFile)) {
					File delFile = new File(upPath + targetFile.replace("/", File.separator));
					oFile = delFile.delete();
					tFile = true;
					this.upfileList.remove(file);
					break;
				}
			}
		}

		String result = null;
		System.out.println("삭제 결과 - " + oFile  + "/" + tFile);
		if (oFile && tFile) {
			result = "success";
		} else {
			result = "fail";
		}
		
		System.out.println("(파일삭제) 현재 파일리스트 : " + this.upfileList.toString());
		return result;
	}
	
	@RequestMapping(value = "/delPrevFile", method = RequestMethod.POST) 
	public ResponseEntity<String> delPrevFile(@RequestParam("fileNoList[]") List<Integer> fileNoList,
			@RequestParam("fileNameList[]") List<String> fileNameList, HttpServletRequest request) {
		System.out.println("기존파일 번호리스트 - " + fileNoList + " 삭제");
		System.out.println("기존파일명 리스트 - " + fileNameList + " 삭제");
		String upPath = request.getSession().getServletContext().getRealPath("");
		boolean oFile = false, tFile = false;
		boolean delFileResult = false;
		ResponseEntity<String> result = null;
		
		boolean DBResult = false;
		try {
			DBResult = rService.deleteAttachFile(fileNoList);
		} catch (Exception e) {
			result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); 
			e.printStackTrace();
		}
		
		if (DBResult) {
			for (String fileName : fileNameList) {
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
					System.out.println("기존 파일명 : " + fileName + " - 삭제 완료(" + oFile  + "/" + tFile + ")");
				} else {
					delFileResult = false;
					System.out.println("기존 파일명 : " + fileName + " - 삭제 실패(" + oFile  + "/" + tFile + ")");
					result = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
					break;
				}
			}
		}
		
		if (delFileResult) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		return result;
	}
	
	@RequestMapping(value="/writeCancel", method = RequestMethod.POST)
	public @ResponseBody String writeCancle(HttpServletRequest req) {
		String upPath = req.getSession().getServletContext().getRealPath("resources/uploads");
		if (!this.upfileList.isEmpty()) {
			for (UploadFile file : this.upfileList) {
				if (file.getThumbnailFileName() != null) {
					File thumb = new File(upPath + file.getThumbnailFileName().replace("/", File.separator));
					thumb.delete();
				}
				File origin = new File(upPath + file.getOriginalFileName().replace("/", File.separator));
				origin.delete();
			}
			this.upfileList.clear();
		}
		
		System.out.println("(작성 취소) 현재 파일리스트 : " + this.upfileList.toString());
		return "success";
	}
}
