package com.bookdabang.lbr.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.FreeBoardComment;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;
import com.bookdabang.common.etc.IPCheck;
import com.bookdabang.lbr.domain.ReportArray;
import com.bookdabang.lbr.etc.BoardUploadFile;
import com.bookdabang.lbr.etc.BoardUploadFileProcess;
import com.bookdabang.lbr.service.FreeBoardService;

@Controller
@RequestMapping(value = "/board/*")
public class FreeBoardController {

	@Inject
	private FreeBoardService service;

	private List<BoardUploadFile> upfileLst = new ArrayList<BoardUploadFile>();

	// 자유게시판 글 전체보기
	@RequestMapping(value = "listAllFreeBoard", method = RequestMethod.GET)
	public void listAllFreeBoard(Model model,
			@RequestParam(value = "pageNo", required = false, defaultValue = "1") String tmp,
			@ModelAttribute BoardSearch search, HttpServletRequest request) throws Exception {

		System.out.println(search.toString());

		HttpSession ses = request.getSession();
		String userId = (String) ses.getAttribute("sessionId");
		MemberVO mem = service.getUser(userId);

		int pageNo = 1;
		if (!tmp.equals("") || tmp != null) {
			pageNo = Integer.parseInt(tmp);
		}
		
		System.out.println(pageNo + "번글" + "검색어" + search.toString());
		Map<String, Object> map = service.listAllBoards(pageNo, search);
		List<FreeBoard> lst = (List<FreeBoard>) map.get("freeBoard");
		PagingInfo paging = (PagingInfo) map.get("paging");
		

		model.addAttribute("mem", mem);
		model.addAttribute("freeBoard", lst);
		model.addAttribute("paging", paging);

	}

	// 자유게시판 글 자세히 보기
	@RequestMapping(value = "readFreeBoard", method = RequestMethod.GET)
	public void readFreeBoard(@RequestParam("boardno") String boardno, Model model, Recommend recommend,
			ReportBoard reportBoard, HttpServletRequest request) throws Exception {

		HttpSession ses = request.getSession();
		String userId = (String) ses.getAttribute("sessionId");

		// String userId = sessionId;

		int no = Integer.parseInt(boardno);

		recommend.setFreeboardNo(no);

		reportBoard.setBoardno(no);

		String ipAddr = IPCheck.getIPAddr(request);

		Map<String, Object> resultMap = service.readFreeBoard(no, ipAddr);

		FreeBoard freeBoard = (FreeBoard) resultMap.get("freeBoard");
		List<AttachFileVO> fileLst = (List<AttachFileVO>) resultMap.get("fileLst");

		MemberVO mem = service.getUser(userId);

		try {
			recommend.setUserId(mem.getUserId());
			reportBoard.setReportuser(mem.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(freeBoard.toString());
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("fileLst", fileLst);
		model.addAttribute("check", this.service.countLikeCheck(recommend));
		model.addAttribute("reportCheck", this.service.countReportCheck(reportBoard));
		model.addAttribute("mem", mem);

	}

	// 자유게시판 글 수정
	@RequestMapping(value = "modifyFreeBoard", method = RequestMethod.GET)
	public void modiFreeBoard(Model model, @RequestParam("boardno") String boardno) throws Exception {

		int no = Integer.parseInt(boardno);
		
		System.out.println(no + "번 수정하자");
		Map<String, Object> resultMap = service.readFreeBoard(no);
		FreeBoard freeBoard = (FreeBoard) resultMap.get("freeBoard");
		AttachFileVO attach = (AttachFileVO)resultMap.get("attach");
		List<AttachFileVO> fileLst = (List<AttachFileVO>) resultMap.get("fileLst");
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("fileLst", fileLst);
		model.addAttribute("attach", attach);

	}

	// 삭제된게시판 전체보기(관리자)
	@RequestMapping(value = "removeAllfreeBoard", method = RequestMethod.GET)
	public void removeAllFreeBoard(Model model, @RequestParam(value = "pageNo", required = false, defaultValue = "1")String tmp, @ModelAttribute BoardSearch search) throws Exception {
		System.out.println("삭제된글 전체보기");
		int pageNo = 1;
		if (!tmp.equals("") || tmp != null) {
			pageNo = Integer.parseInt(tmp);
		} 
		Map<String, Object> map = service.removeAllFreeBoard(pageNo,search);
		List<FreeBoard> lst = (List<FreeBoard>)map.get("removeBoard");
		model.addAttribute("removeBoard", lst);
		PagingInfo paging = (PagingInfo) map.get("paging");
		model.addAttribute("paging", paging);
		
	}

	@RequestMapping(value = "readDelBoard", method = RequestMethod.GET)
	public void readDelBoard(@RequestParam("boardno") String boardno, Model model) throws Exception {
		System.out.println("!");
		int no = Integer.parseInt(boardno);
		FreeBoard freeBoard = service.readDelBoard(no);
		model.addAttribute("freeBoard", freeBoard);
	}

	// 신고게시판 전체보기(관리자)
	@RequestMapping(value = "listAllReportBoard", method = RequestMethod.GET)
	public void listAllReportBoard(Model model,
			@RequestParam(value = "pageNo", required = false, defaultValue = "1") String tmp,@ModelAttribute ReportArray array) throws Exception {
		System.out.println("신고게시판 글");
		int pageNo = 1;
		if (!tmp.equals("") || tmp != null) {
			pageNo = Integer.parseInt(tmp);
		} 
		
		System.out.println(array.toString());
		
		Map<String, Object> map = service.listAllReportBoards(pageNo,array);
		List<ReportBoard> lst = (List<ReportBoard>) map.get("reportBoard");
		PagingInfo paging = (PagingInfo) map.get("paging");

		model.addAttribute("paging", paging);
		model.addAttribute("reportBoard", lst);
	}

	@RequestMapping(value = "moreReport", method = RequestMethod.GET)
	public void moreReport(Model model, @RequestParam("reportno") String reportno,
			@RequestParam("boardno") String boardno) throws Exception {
		int boardNo = Integer.parseInt(boardno);
		int reportNo = Integer.parseInt(reportno);
		
		Map<String, Object> resultMap = service.readFreeBoard(boardNo);
		FreeBoard freeBoard = (FreeBoard) resultMap.get("freeBoard");

		ReportBoard reportboard = null;
		reportboard =  service.readreportBoard(reportNo);
		
		model.addAttribute("freeboard", freeBoard);
		model.addAttribute("reportboard", reportboard);
	}

	@RequestMapping(value = "reportStatus", method = RequestMethod.POST)
	public ResponseEntity<String> reportStatus(@RequestParam("boardno") String boardno,
			@RequestParam("reportno") String reportno) throws Exception {
		int board = Integer.parseInt(boardno);
		int report = Integer.parseInt(reportno);

		// System.out.println(board + "//" + report);
		ResponseEntity<String> result = null;

		try {
			if (service.reportfreeBoard(board) == true && service.reportStatus(report) == true) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return result;

	}

	// 게시판 글 신고하기
	@RequestMapping(value = "insertReportBoard", method = RequestMethod.POST)
	public ResponseEntity<String> insertReportBoard(@RequestParam("boardno") String boardno,
			@RequestParam("why") String why, ReportBoard reportBoard, HttpServletRequest request) throws Exception {
		int no = Integer.parseInt(boardno);
		HttpSession ses = request.getSession();
		String userId = (String) ses.getAttribute("sessionId");
		// String userId = sessionId;
		MemberVO mem = service.getUser(userId);
		reportBoard.setReportuser(mem.getUserId());
		reportBoard.setBoardno(no);
		ResponseEntity<String> result = null;

		System.out.println("게시판 신고하기");
		if (service.insertReportBoard(reportBoard)) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
			
		} else {
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return result;
	}

	// 자유게시판 글 쓰기
	@RequestMapping(value = "insertFreeBoard", method = RequestMethod.GET)
	public void insertFreeBoard(@RequestParam("userId") String userId, Model model) {
		System.out.println("게시판 글쓰기");
		model.addAttribute("userId", userId);

	}

	@RequestMapping(value = "createFreeBoard", method = RequestMethod.POST)
	public String createFreeBoard(FreeBoard freeBoard, RedirectAttributes ra) throws Exception {
		System.out.println("자유게시판 등록해");

		if (service.createFreeBoard(freeBoard, this.upfileLst)) {
			ra.addFlashAttribute("result", "success");
		} else {
			ra.addFlashAttribute("result", "fail");
		}
		return "redirect:/board/listAllFreeBoard";
	}
	
	
	@RequestMapping(value = "updateFreeBoard", method = RequestMethod.POST)
	public String updateFreeBoard(@RequestParam("boardno") String boardno, FreeBoard freeboard) throws Exception {
		
		int boardNo = Integer.parseInt(boardno);
		System.out.println(boardNo+"!!!1");
		service.updateFreeBoard(freeboard);
		System.out.println(freeboard.toString());
		
		return "redirect:/board/readFreeBoard?boardno="+boardNo;
		
	}

	// 자유게시판 글 삭제
	@RequestMapping(value = "removeFreeBoard", method = RequestMethod.POST)
	public ResponseEntity<String> removeFreeBoard(@RequestParam("boardno") String boardno) throws Exception {
		int no = Integer.parseInt(boardno);
		System.out.println(boardno + "번 삭제하자");
		ResponseEntity<String> result = null;
		if (service.removeFreeBoard(no)) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return result;

	}

	// 삭제된 게시물 복구
	@RequestMapping(value = "restoreBoard", method = RequestMethod.POST)
	public ResponseEntity<String> restoreBoard(@RequestParam("boardno") String boardno, RedirectAttributes ra)
			throws Exception {
		int no = Integer.parseInt(boardno);
		System.out.println("복구시키장");

		ResponseEntity<String> result = null;

		if (service.restorBoard(no)) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return result;

	}

	// 파일 업로드
	@RequestMapping(value = "uploadsFile", method = RequestMethod.POST)
	public ResponseEntity<BoardUploadFile> upFile(MultipartFile upfile, HttpServletRequest request) {
		System.out.println("업로드된 파일 이름 " + upfile.getOriginalFilename());
		System.out.println("업로드된 파일 사이즈 " + upfile.getSize());
		System.out.println("업로드된 파일 타입 " + upfile.getContentType());
		System.out.println("파일 separator " + File.separator);

		String upPath = request.getSession().getServletContext().getRealPath("resources/boardUploads");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);

		BoardUploadFile uploadFile = null;
		ResponseEntity<BoardUploadFile> result = null;

		if (upfile.getSize() > 0) {
			BoardUploadFileProcess ufp = new BoardUploadFileProcess();

			try {
				uploadFile = ufp.uploadFileRename(upPath, upfile.getOriginalFilename(), upfile.getBytes());
				this.upfileLst.clear();
				this.upfileLst.add(uploadFile);
				result = new ResponseEntity<BoardUploadFile>(uploadFile, HttpStatus.OK); // 통신성공
			} catch (IOException e) {
				result = new ResponseEntity<>(HttpStatus.BAD_REQUEST); // 통신실패
				e.printStackTrace();
			}

			System.out.println(uploadFile.toString());
			// 경로명 + 파일을 DB에 저장해야하고, jsp단에 업로드된 파일이 표시되도록 해야함.
		}
		System.out.println("현재파일리스트 :" + this.upfileLst.toString());
		return result;

	}
//
	@RequestMapping(value = "/removeFile", method = RequestMethod.POST)
	public @ResponseBody String removeFile(@RequestParam("targetFile") String targetFile, HttpServletRequest request) {
		System.out.println(targetFile + "을 지우자!");
		String upPath = request.getSession().getServletContext().getRealPath("resources/boardUploads/"); // 물리적경로
		
		//boolean oFile = false, tFile = false;
		//File delFile = new File(upPath+targetFile.replace("/", File.separator));
		System.out.println("upPath : " + upPath);

		// 파일이 존재하면 
		//delFile.delete(); // 파일 삭제 

		
		
			
				File thumb = new File(upPath+targetFile.replace("/", File.separator));
				thumb.delete();
				BoardUploadFile file = null;
				 System.out.println(file.getOriginalFileName()); 
			

		//this.upfileLst.clear();
	

//		if(tFile.exists()) {
//			tFile.delete(); 
//
//			System.out.print("파일삭제");
//		}else {
//			System.out.print("파일삭제실패");
//		}

		
		return "success";
	}
//	

	// 파일 삭제
	@RequestMapping(value = "/delFile", method = RequestMethod.POST)
	public @ResponseBody String delFlie(@RequestParam("targetFile") String targetFile, HttpServletRequest request) {
		System.out.println(targetFile + "을 지우자!");
		String upPath = request.getSession().getServletContext().getRealPath("resources/boardUploads"); // 물리적경로

		boolean oFile = false, tFile = false;

		for (BoardUploadFile file : this.upfileLst) {
			if (file.getThumbnailFileName() != null) {
				if (file.getThumbnailFileName().equals(targetFile)) {
					File delFile = new File(upPath + targetFile.replace("/", File.separator));
					tFile = delFile.delete(); // 썸네일 파일이 삭제
					File originFile = new File(upPath + file.getOriginalFileName().replace("/", File.separator));
					oFile = originFile.delete(); // 원본 파일 삭제
					this.upfileLst.remove(file); // 리스트에서 삭제

					break;
				}
			}

			if (file.getNotImageFileName() != null) {
				if (file.getNotImageFileName().equals(targetFile)) { // 이미지파일 아님
					File delFile = new File(upPath + targetFile.replace("/", File.separator));
					oFile = delFile.delete();
					tFile = true;
					this.upfileLst.remove(file); // 리스트에서 삭제
					break;
				}
			}
		}

		String result = null;

		System.out.println(oFile + "/" + tFile);

		if (oFile && tFile) {
			result = "success";

		} else {
			result = "fail";
		}

		System.out.println("현재파일리스트 :" + this.upfileLst.toString());
		return result;
	}

	// 글 등록 취소
	@RequestMapping(value = "/cancelFreeBoard", method = RequestMethod.POST)
	public @ResponseBody String cancelFreeBoard(HttpServletRequest req) {
		String upPath = req.getSession().getServletContext().getRealPath("resources/boardUploads");
		if (!this.upfileLst.isEmpty()) {
			for (BoardUploadFile file : this.upfileLst) {
				if (file.getThumbnailFileName() != null) {
					File thumb = new File(upPath + file.getThumbnailFileName().replace("/", File.separator));
					thumb.delete();
				}
				File origin = new File(upPath + file.getOriginalFileName().replace("/", File.separator));
				origin.delete();
			}

			this.upfileLst.clear();
		}

		return "success";
	}

	
	
	

	// 게시판 글 좋아요
	@RequestMapping(value = "likeFreeBoard", method = RequestMethod.POST)
	public String likeFreeBoard(@RequestParam("boardno") String boardno, @RequestParam("gubun") String gubun,
			Recommend recommend, HttpServletRequest request) throws Exception {
		int no = Integer.parseInt(boardno);
		HttpSession ses = request.getSession();
		// String userId = sessionId;
		String userId = (String) ses.getAttribute("sessionId");
		MemberVO mem = service.getUser(userId);

		recommend.setFreeboardNo(no);
		recommend.setUserId(mem.getUserId());

		// 좋아요가 있는
		if (gubun.equals("Y")) {
			this.service.likeFreeBoard(recommend);
			this.service.likeCount(no);
			// 좋아요가 없는
		} else {
			this.service.unlikeFreeBoard(recommend);
			this.service.delLikeCount(no);
		}
		return "/board/readFreeBoard";
	}

	@RequestMapping(value = "adminFreeBoard", method = RequestMethod.GET)
	public void adminFreeBoard(Model model,@RequestParam(value = "pageNo", required = false, defaultValue = "1") String tmp,@ModelAttribute BoardSearch search) throws Exception {

		
		
		int pageNo = 1;
		if (!tmp.equals("") || tmp != null) {
			pageNo = Integer.parseInt(tmp);
		}
		
		
		
		Map<String, Object> map = service.listAllBoards(pageNo, search);
		List<FreeBoard> lst = (List<FreeBoard>) map.get("freeBoard");
		PagingInfo paging = (PagingInfo) map.get("paging");
		

		
		model.addAttribute("freeBoard", lst);
		model.addAttribute("paging", paging);
		System.out.println("관리");
	}		
	
	
	@RequestMapping(value = "adminRead", method = RequestMethod.GET)
	public void adminRead(@RequestParam("boardno") int boardno, Model model) throws Exception{
		System.out.println(boardno);
		
		Map<String, Object> resultMap = service.readFreeBoard(boardno);
		FreeBoard freeBoard = (FreeBoard) resultMap.get("freeBoard");
		List<AttachFileVO> fileLst = (List<AttachFileVO>) resultMap.get("fileLst");
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("fileLst", fileLst);
		
		
	}
	
	
	@RequestMapping(value = "adminRemove", method = RequestMethod.POST)
	public ResponseEntity<String> adminRemove(@RequestParam("boardno") String boardno)
			throws Exception {
		int no = Integer.parseInt(boardno);
		System.out.println("영구삭제시키장");

		ResponseEntity<String> result = null;

		if (service.adminRemove(boardno)==true || (service.admindelAttach(boardno)==true)) {
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}

		return result;

	}

	
}
