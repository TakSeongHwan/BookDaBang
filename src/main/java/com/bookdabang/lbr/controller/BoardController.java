package com.bookdabang.lbr.controller;

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
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;

import com.bookdabang.lbr.etc.BoardUploadFile;
import com.bookdabang.lbr.etc.BoardUploadFileProcess;
import com.bookdabang.lbr.service.BoardService;

@Controller
@RequestMapping(value = "/board/*")
public class BoardController {

	@Inject
	private BoardService service;

	private List<BoardUploadFile> upfileLst = new ArrayList<BoardUploadFile>();

	@RequestMapping(value = "listAllFreeBoard", method = RequestMethod.GET)
	public void listAllFreeBoard(Model model) throws Exception {
		System.out.println("글");
		List<FreeBoard> lst = service.listAllBoards();
		model.addAttribute("freeBoard", lst);

	}

	@RequestMapping(value = "readFreeBoard", method = RequestMethod.GET)
	public void readFreeBoard(@RequestParam("boardno") String boardno, Model model, Recommend recommend, ReportBoard reportBoard)
			throws Exception {
		
		int no = Integer.parseInt(boardno);

		recommend.setFreeboardNo(no);
		recommend.setUserId("cat");

//		reportBoard.setBoardno(no);
//		reportBoard.setReportuser("cat");
		
		Map<String, Object> resultMap = service.readFreeBoard(no);
		
		FreeBoard freeBoard = (FreeBoard)resultMap.get("freeBoard");
		List<AttachFileVO> fileLst = (List<AttachFileVO>)resultMap.get("fileLst");
		System.out.println(freeBoard.toString());
		model.addAttribute("freeBoard", freeBoard);
		model.addAttribute("fileLst", fileLst);
		model.addAttribute("check", this.service.countLikeCheck(recommend));
		//model.addAttribute("reportCheck", this.service.countReportCheck(reportBoard));

	}

	@RequestMapping(value = "removeAllfreeBoard", method = RequestMethod.GET)
	public void removeAllFreeBoard(Model model) throws Exception {
		System.out.println("삭제된글 전체보기");
		List<FreeBoard> lst = service.removeAllFreeBoard();
		model.addAttribute("removeBoard", lst);
	}

	@RequestMapping(value = "readDelBoard", method = RequestMethod.GET)
	public void readDelBoard(@RequestParam("boardno") String boardno, Model model) throws Exception {
		System.out.println("!");
		int no = Integer.parseInt(boardno);
		FreeBoard freeBoard = service.readDelBoard(no);
		model.addAttribute("freeBoard", freeBoard);
	}

	@RequestMapping(value = "listAllReportBoard", method = RequestMethod.GET)
	public void listAllReportBoard(Model model) throws Exception {
		System.out.println("신고게시판 글");
		List<ReportBoard> lst = service.listAllReportBoards();
		model.addAttribute("reportBoard", lst);
	}

	@RequestMapping(value = "insertReportBoard", method = RequestMethod.POST)
	public void insertReportBoard(@RequestParam("boardno") String boardno, @RequestParam("why") String why ,ReportBoard reportBoard, RedirectAttributes ra) throws Exception {
		int no = Integer.parseInt(boardno);
		reportBoard.setReportuser("cat");
		reportBoard.setBoardno(no);
		System.out.println("게시판 신고하기");
		if (this.service.insertReportBoard(reportBoard)) {
			ra.addFlashAttribute("result", "success");
		} else {
			ra.addFlashAttribute("result", "fail");
		}

	}

//	@RequestMapping(value = "readReportBoard", method = RequestMethod.GET)
//	public void readReportBoard(@RequestParam("boardno") String boardno, Model model) throws Exception {
//		int no = Integer.parseInt(boardno);
//		System.out.println(no + "신고게시판 글 자세히보자");
//      
	
//		
//		
//
//	}

	@RequestMapping(value = "insertFreeBoard", method = RequestMethod.GET)
	public void insertFreeBoard() {
		System.out.println("게시판 글쓰기");

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

	@RequestMapping(value = "removeFreeBoard", method = RequestMethod.POST)
	public String removeFreeBoard(@RequestParam("boardno") String boardno) throws Exception {
		int no = Integer.parseInt(boardno);
		System.out.println(boardno + "번 삭제하자");
		String result = null;
		if(this.service.removeFreeBoard(no)) {
			result = "success";
		} else {
			result="fail";
		}

		return result;

	}

	@RequestMapping(value = "restoreBoard", method = RequestMethod.POST)
	public String restoreBoard(@RequestParam("boardno") String boardno, RedirectAttributes ra) throws Exception {
		int no = Integer.parseInt(boardno);
		System.out.println("복구시키장");

		service.restorBoard(no);

		return "/board/readDelBoard";

	}

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

	@RequestMapping(value = "likeFreeBoard", method = RequestMethod.POST)
	public String likeFreeBoard(@RequestParam("boardno") String boardno, @RequestParam("gubun") String gubun,
			Recommend recommend) throws Exception {
		int no = Integer.parseInt(boardno);

		recommend.setFreeboardNo(no);
		recommend.setUserId("cat");

		// 좋아요가 있는
		if (gubun.equals("Y")) {
			this.service.likeFreeBoard(recommend);
			// 좋아요가 없는
		} else {
			this.service.unlikeFreeBoard(recommend);
		}
		return "/board/readFreeBoard";
	}
}
