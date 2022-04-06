package com.bookdabang.lhs.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.common.etc.IPCheck;
import com.bookdabang.common.service.IPCheckService;
import com.bookdabang.lhs.etc.ImageFileHandling;
import com.bookdabang.lhs.etc.UploadFileProcess;
import com.bookdabang.lhs.service.NoticeService;
import com.bookdabang.ljs.service.LoginService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

	@Inject
	NoticeService service;
	
	@Inject
	IPCheckService ipService;
	
	@Inject
	private LoginService loginService;

	private List<AttachFileVO> fileList = new ArrayList<AttachFileVO>();

	@RequestMapping("listAll")
	public String notice(Model m) {
		List<NoticeVO> notice = new ArrayList<NoticeVO>();
		try {
			notice = service.entireNotice();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		m.addAttribute("notice", notice);
		return "notice/notice";
	}

	@RequestMapping("viewContent")
	@Transactional
	public void showNoticeContent(Model m, @RequestParam("no") int no, HttpServletRequest request) {
		System.out.println(no);
		NoticeVO content = null;
		List<AttachFileVO> af = null;
		String ipaddr = null;
		try {
			ipaddr = IPCheck.getIPAddr(request);
			//System.out.println("세션에 넣어둔 ip가 잘 저장되어있나? "+request.getSession().getAttribute("ipAddr"));
			Timestamp lastAccessTime = service.pageViewCheck(ipaddr, no);
		
			System.out.println(lastAccessTime);
			if(lastAccessTime != null) {
				
				long lastAccessDate = lastAccessTime.getTime();
				long currTime = System.currentTimeMillis();
				
				if(currTime - lastAccessDate > 1000 * 60*60*24) {//테스트중이라 1분 
					if(service.updateAccessDate(ipaddr, no) == 1) {
						service.viewCountIncrese(no);
						System.out.println("조회수 올라감");
					}
				}else {
					System.out.println("조회수 안올라감");
				}
			}else {
				if(service.insertAccessDate(ipaddr, no) == 1) {
					service.viewCountIncrese(no);
					System.out.println("조회수 올라감");
				}
				
			}
			
			content = service.getContentByNo(no);
			af = service.getAttachFile(no);
			if(af.size()<1) {
				af = null;
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(content);
		
		m.addAttribute("attachFile", af);
		m.addAttribute("content", content);
	}

	@RequestMapping("viewNoticeWrite")
	public String showNoticeWritePage() {
		return "/notice/insertNotice";

	}

	@RequestMapping(value = "insertNotice", method = RequestMethod.POST)
	public String insertNotice(NoticeVO n, RedirectAttributes rttr) {
		
	
		int no = 0;
		try {
			no = service.getNoticeNo() + 1;
			n.setNo(no);
			
			if(service.insertNotice(n) == 1) {
				
				for(AttachFileVO af : this.fileList) {
					service.insertAttachFile(af, no);
				}
				rttr.addFlashAttribute("result", "success");
			}
			
				
		
		} catch (Exception e) {
			rttr.addFlashAttribute("result", "fail");
			e.printStackTrace();
		}
		
		
		
		return "redirect:/notice/listAll";
	}
	
	
	@RequestMapping(value="updateNotice", method=RequestMethod.POST)
	public void updateNotice() {
		
	}
	
	@RequestMapping("deleteNotice")
	public String deleteNotice(@RequestParam int no, RedirectAttributes rttr) {
		System.out.println("삭제할 게시물"+no);
		int result = 0;
		try {
			result = service.deleteNotice(no);
			if(result == 1) {
				rttr.addFlashAttribute("result", "success");
			}
		} catch (Exception e) {
			rttr.addFlashAttribute("result", "fail");
			e.printStackTrace();
		}
		return "redirect:/notice/listAll";
	}

	@RequestMapping(value = "imageHandling", method = RequestMethod.POST)
	public ResponseEntity<String> imageHandling(MultipartFile imageFile, HttpServletRequest request) {

		long maxFileSize = 1024 * 1024 * 10;

		ResponseEntity<String> result = null;

		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads/noticeBoardImg");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);

		long fileSize = imageFile.getSize();
		String orgFileName = imageFile.getOriginalFilename();

		ImageFileHandling ifh = new ImageFileHandling();

		if (fileSize <= maxFileSize) {

			try {

				ifh.fileUploading(orgFileName, upPath, imageFile.getBytes());

				System.out.println(orgFileName);
				result = new ResponseEntity<String>(orgFileName, HttpStatus.OK);

			} catch (IOException e) {
				// TODO Auto-generated catch block
				result = new ResponseEntity<String>("fail:uploadingFail", HttpStatus.BAD_REQUEST);
				e.printStackTrace();
			}

		} else {

			result = new ResponseEntity<String>("fail:fileSizeOver", HttpStatus.BAD_REQUEST);

		}
		System.out.println(result);
		System.out.println("올라간 파일 : " + orgFileName);
		return result;

	}

	@RequestMapping(value = "delImgFile", method = RequestMethod.POST)
	public ResponseEntity<String> delImgFile(@RequestParam("fileName") String fileName, HttpServletRequest request) {
		System.out.println(fileName);
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads/noticeBoardImg/");
		ImageFileHandling ifh = new ImageFileHandling();
		ResponseEntity<String> returnVal = null;
		boolean result = ifh.fileDelete(upPath, fileName);
		if (result) {
			returnVal = new ResponseEntity<String>("file deleted", HttpStatus.OK);
		} else if (result) {
			returnVal = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		return returnVal;

	}

	@RequestMapping(value = "attactFileUpload", method = RequestMethod.POST)
	public ResponseEntity<AttachFileVO> attachFileHandling(MultipartFile upfile, HttpServletRequest request) {
		System.out.println("컨트롤러단!");

		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads/attachFile");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);
		AttachFileVO uploadFile = null;

		ResponseEntity<AttachFileVO> result = null;
		System.out.println(upfile);
		if (upfile.getSize() > 0) {

			UploadFileProcess ufp = new UploadFileProcess();

			try {
				uploadFile = ufp.uploadFileRename(upPath, upfile.getOriginalFilename(), upfile.getBytes());
				this.fileList.add(uploadFile);
				result = new ResponseEntity<AttachFileVO>(uploadFile, HttpStatus.OK);

			} catch (IOException e) {
				result = new ResponseEntity<AttachFileVO>(HttpStatus.BAD_REQUEST);
				e.printStackTrace();
			}
		}
		return result;
	}

	@RequestMapping(value = "attachFileDelete", method = RequestMethod.POST)
	public ResponseEntity<String> delAttachFile(@RequestParam("thumbnailFile") String thumbnailFile,
			@RequestParam("notImageFile") String notImageFile, @RequestParam("originFile") String originFile,
			HttpServletRequest request) {
		boolean oriFile = false;
		boolean tFile = false;
		ResponseEntity<String> result = null;
		System.out.println(notImageFile);
		System.out.println(originFile);
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads/attachFile");

		ImageFileHandling ifh = new ImageFileHandling();
		for (AttachFileVO af : this.fileList) {
			if (af.getOriginFile().equals(originFile)) {
				if (thumbnailFile != null) {
					oriFile = ifh.fileDelete(upPath, originFile);
					tFile = ifh.fileDelete(upPath, thumbnailFile);
					this.fileList.remove(af);
					break;

				} else if (notImageFile != null) {
					oriFile = ifh.fileDelete(upPath, notImageFile);
					tFile = true;
					this.fileList.remove(af);
					break;
				}

				if (oriFile && tFile) {
					result = new ResponseEntity<String>("success", HttpStatus.OK);
				} else {
					result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
				}
			}
		}

		System.out.println("남아있는 파일 : " + this.fileList);

		return result;

	}

	@RequestMapping(value = "/uploadCancle", method = RequestMethod.POST)
	public ResponseEntity<String> writeCancle(HttpServletRequest req, @RequestParam("targetFile") String targetFile) {
		
		
		ImageFileHandling ifh = new ImageFileHandling();
		String upPathImg = req.getSession().getServletContext().getRealPath("resources/uploads/noticeBoardImg/");
		String upPathAttach = req.getSession().getServletContext().getRealPath("resources/uploads/attachFile");
		ResponseEntity<String> result = null;
		if (!this.fileList.isEmpty()) {
			
			
			for (AttachFileVO af : this.fileList) {
				System.out.println("알 수 없지만");
				
				if (af.getThumbnailFile() != null) {

					System.out.println(af.getThumbnailFile());
					ifh.fileDelete(upPathAttach, af.getThumbnailFile());
					
				}
				ifh.fileDelete(upPathAttach, af.getOriginFile());
				
			}
		}
	
		ifh.fileDelete(upPathImg, targetFile);
		
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return result;
	}
	@RequestMapping("getUserId")
	public ResponseEntity<Map<String,String>> getUserId(@RequestParam("sessionId") String sessionId) {
		ResponseEntity<Map<String,String>> result = null;
		MemberVO mv = null;
		Map<String,String> map = null;
		try {
			mv = loginService.findLoginSess(sessionId);
			System.out.println(mv);
			if(mv != null) {
				map.put("userId", mv.getUserId());
				result = new ResponseEntity<Map<String,String>>(map, HttpStatus.OK);
			}
		} catch (Exception e) {
			
			result = new ResponseEntity<Map<String,String>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return result;
		
	}

}
