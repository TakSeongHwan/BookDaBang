package com.bookdabang.ljs.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.CSUploadFile;
import com.bookdabang.ljs.domain.CSUploadFileProcess;
import com.bookdabang.ljs.service.CSBoardService;
import com.bookdabang.ljs.service.LoginService;
import com.google.protobuf.Timestamp;





@Controller
@RequestMapping("/cs/*")
public class CSBoardController {

	@Inject
	private LoginService service;
	
	@Inject
	CSBoardService cservice;
	
	private List<CSUploadFile> upfileLst = new ArrayList<CSUploadFile>();
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String csBoardAll (Model model) {
		
		
		List<CustomerService> boardList = null;
		
		boardList = cservice.showEntireCSBoard();
		
		System.out.println("게시글 다 가지고 왔는지" + boardList.toString());
		
		model.addAttribute("boardList", boardList);
		
		
		return "cs/csBoardList";
	}
	
	@RequestMapping(value = "/readPost", method = RequestMethod.GET)
	public void readCSPost(@RequestParam("no") int postNo, Model model) {
		
//		Map<String, Object> resultMap 
//		CustomerService cs = cservice.readCSBoard(postNo);
//		cs.get
//		
//		CustomerService csPost = (csPost)resultMap.get("csBoard");
//		
//		List<AttachFileVO> attachLst = (List<AttachFileVO>)resultMap.get("attachLst");
//		//가져오는거 까야됨 어떻게 까냐?
//		
//		model.addAttribute("csBoard", csPost);
//		model.addAttribute("attachLst", attachLst);
//		
//		System.out.println(csPost.toString());
//		
//		model.addAttribute("csBoard", csPost);
	}
	
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String writePost(Model model, @RequestParam("u") String sessionId, HttpServletResponse response) {
		
		System.out.println(sessionId);
		
		MemberVO loginMember = null;
		try {
		loginMember = service.findLoginSess(sessionId);
		
		if (loginMember != null) {
			
			model.addAttribute("loginMember" ,loginMember);	
		} else {
			
			response.sendRedirect("login.jsp");
		}
		
		
		} catch (Exception e) {
			System.out.println("글쓰기 실패");
			e.printStackTrace();
		}
		
		return "cs/writeCSPost";
	}
	
	
	@RequestMapping(value = "/write.do", method = RequestMethod.POST) // 저장 버튼 눌렀을 때, 시간을 기억하도록.
	public String writeCSPost(CustomerService csPost) {

		System.out.println(System.currentTimeMillis());
		
		System.out.println(csPost.toString());
		
		java.sql.Timestamp writeTime = null;
		writeTime = writeTime.valueOf(LocalDateTime.now());
		
		csPost.setPostdate(writeTime); 
		
		
		
		// 세션에 시간을 넣어보는게 어떨까
		
		
		// 시간, 말머리, 제목, userId, 내용 
		
		int result = cservice.writeCSPost(csPost);
		
		System.out.println("결과 : " + result); 
		
		return "cs/afterWriting";
	}
	
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public ResponseEntity<CSUploadFile> upFile(MultipartFile upfile, HttpServletRequest request) throws IOException {
		System.out.println("업로드된 파일 이름 : " + upfile.getOriginalFilename());
		System.out.println("파일사이즈" + upfile.getSize());
		System.out.println("파일의 타입" + upfile.getContentType());
		System.out.println("파일 구분자 : " + File.separator);

		String upPath = request.getSession().getServletContext().getRealPath("resources/cs_uploads"); // 파일을 올리기 위한 '서버' 상
																									// 경로
		System.out.println("파일이 업로드되는 실제 물리적 경로 : " + upPath); // 파일이 업로드되는 실제 경로.

		CSUploadFile uploadFile = null;

		ResponseEntity<CSUploadFile> result = null;

		if (upfile.getSize() > 0) { // 실제 파일이 업로드 되었다면...

			CSUploadFileProcess utp = new CSUploadFileProcess(); // 객체 생성
			// JSP에서와의 달리, FileItem이 필요없다는 점을 생각해야함.
			// 실제 파일 업로드 + 썸네일 + db에 저장될 이름을 얻어왔다.
			try {
				uploadFile = utp.uploadFileRename(upPath, upfile.getOriginalFilename(), upfile.getBytes());
				this.upfileLst.add(uploadFile);
				result = new ResponseEntity<CSUploadFile>(uploadFile, HttpStatus.OK);

			} catch (IOException e) {
				result = new ResponseEntity<>(HttpStatus.BAD_REQUEST); // 통신실패
				e.printStackTrace();

			}

			// 경로명 + 파일을 DB에 저장해야하고, jsp 단에 업로드된 파일이 표시하도록 해야한다.
		}
		System.out.println("현재 파일리스트 : " + this.upfileLst.toString());
		return result;

	}
	
	@RequestMapping(value = "/delFile", method = RequestMethod.POST)
	public @ResponseBody String delFile(@RequestParam("targetFile") String targetFile, HttpServletRequest request) throws IOException {
		
		String upPath = request.getSession().getServletContext().getRealPath("resources/cs_uploads");
		
		boolean oFile = false, tFile = false;
		
		for (CSUploadFile file : this.upfileLst) {
			
			if (file.getThumbnailFileName() != null) { // 썸네일파일 이름이 있다면.
				if (file.getThumbnailFileName().equals(targetFile)) { // 썸네일 파일 이름이 뷰단에서 보낸, (삭제 버튼이 눌려) 삭제될 대상인 targetFile과 같다면..
					File delFile = new File(upPath + targetFile.replace("/", File.separator));
					tFile = delFile.delete(); // 썸네일 파일이 삭제
					System.out.println(tFile);
					File originFile = new File(file.getOriginalFileName().replace("/", File.separator));
					System.out.println("에러 뜨는 부분" + originFile.toString());
					System.out.println("오리지널 파일 이름 " + file.getOriginalFileName() );
					oFile = originFile.delete(); // 원본 파일 삭제
					System.out.println(oFile);  // 여기서 false 뜸..
					this.upfileLst.remove(file);
					break;
				}
			}
			if (file.getNotImageFileName() != null) {
				if (file.getNotImageFileName().equals(targetFile)) {
					File delFile = new File(upPath + targetFile.replace("/", File.separator));
					oFile = delFile.delete();
					tFile = true;
					this.upfileLst.remove(file); // 리스트에서 삭제
				}
			}
		}
		
		String result = null;

		if (oFile && tFile) {
			result = "success";
		} else {
			result = "fail";
		}

		System.out.println("현재 파일리스트 : " + this.upfileLst.toString());
		return result;
		
	}
	
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public void deleteCSPost(@RequestParam("no") int postNo, Model model) {

		System.out.println("게시글 삭제하러 가자");
		
			
	}
	
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyCSPost(@RequestParam("no") int postNo, Model model) {

		System.out.println("게시글 수정하러 가자");
		
			
	}
	
	
	
	
	
	
}