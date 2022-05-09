package com.bookdabang.lhs.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.NoticeVO;
import com.bookdabang.common.domain.PagingInfo;
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
	public String notice(Model m, HttpServletRequest request, @RequestParam(value="pageNo",required=false, defaultValue="1") String currPg,
			@ModelAttribute BoardSearch bs) {
		List<NoticeVO> notice = new ArrayList<NoticeVO>();

		String sessionId = request.getSession().getId();
	
		
		ResponseEntity<Map<String,String>> result = null;
		MemberVO mv = null;
		
		int pageNo = 1;
		if(!currPg.equals("") || currPg != null) {
			pageNo = Integer.parseInt(currPg);
		}
		if(bs.getSearchWord() == null) {
			bs.setSearchWord("");
		}
		if(bs.getSearchType() == null) {
			bs.setSearchType("");
		}
		
		
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		PagingInfo pi = null;
		System.out.println("검색 : "+bs);
		try {
			mv = loginService.findLoginSess(sessionId);
			System.out.println(mv);
			
			if(mv != null) {
			m.addAttribute("userId", mv.getUserId());
			}
			
			Map<String,Object> map = service.entireNotice(pageNo, bs);
			list = (List<NoticeVO>) map.get("notice");
			pi = (PagingInfo) map.get("pagingInfo");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		m.addAttribute("notice",list);
		m.addAttribute("pagingInfo",pi);
		return "notice/notice";
	}

	@RequestMapping("viewContent")
	public void showNoticeContent(Model m, @RequestParam("no") int no, HttpServletRequest request) {
		System.out.println(no);
		NoticeVO content = null;
		List<AttachFileVO> af = null;
		String ipaddr = null;
		
		String sessionId = request.getSession().getId();
		System.out.println(sessionId);
		
		ResponseEntity<Map<String,String>> result = null;
		MemberVO mv = null;
		
		try {
			
			mv = loginService.findLoginSess(sessionId);
			System.out.println(mv);
			if(mv != null) {
			m.addAttribute("userId", mv.getUserId());
				
			}
			
			ipaddr = IPCheck.getIPAddr(request);
			content = service.getContentByNo(ipaddr,no);
			if(content.getImage().length() == 0) {
				content.setImage(null);
			}
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
	public String showNoticeWritePage(HttpServletRequest request, Model m) {
		
		String sessionId = request.getSession().getId();
		System.out.println(sessionId);
		
		ResponseEntity<Map<String,String>> result = null;
		MemberVO mv = null;
	
			try {
				mv = loginService.findLoginSess(sessionId);
				System.out.println(mv);
				if(mv != null) {
				m.addAttribute("loginUser", mv);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
		
		return "/notice/insertNotice";

	}

	@RequestMapping(value = "insertNotice", method = RequestMethod.POST)
	public String insertNotice(NoticeVO n, RedirectAttributes rttr) {
	
	
			try {
				int no = service.getNoticeNo() + 1;
				n.setNo(no);
				if(service.insertNotice(n) == 1) {
					
					for(AttachFileVO af : this.fileList) {
						service.insertAttachFile(af, n.getNo() );
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
	public String updateNotice(NoticeVO n, RedirectAttributes rttr, MultipartHttpServletRequest multipartRequest, HttpServletRequest request) {
		
		boolean newImageUploadCheck = Boolean.parseBoolean(request.getParameter("newImageUploadCheck"));
		boolean newAttachUploadCheck = Boolean.parseBoolean(request.getParameter("newAttachUploadCheck"));
	
		ImageFileHandling ifhl = new ImageFileHandling();
		UploadFileProcess ufp = new UploadFileProcess();
		
		String oldImgName = request.getParameter("oldImgName");
		String[] oldAttachFileName = request.getParameterValues("deletedAttachFile");
		
		System.out.println("첨부파일 삭제 : " + oldAttachFileName);
		
		String upPathImg = request.getSession().getServletContext().getRealPath("resources/uploads/noticeBoardImg/");
		String upPathAttach =  request.getSession().getServletContext().getRealPath("resources/uploads/attachFile");
		
		try {
			if(newImageUploadCheck) {
				String newImage = multipartRequest.getFile("newImgFile").getOriginalFilename();
				if(newImage != null) {
					n.setImage(newImage);
					ifhl.fileUploading(newImage, upPathImg, multipartRequest.getFile("newImgFile").getBytes());
					if(service.updateNewImageFile(newImage, n.getNo()) == 1) {						
					}
				}
			}else {
				System.out.println("새로운 이미지 등록 없음");
			}
			
			if(newAttachUploadCheck) {
				List<MultipartFile> list = multipartRequest.getFiles("newAttachFile");
				AttachFileVO uploadFile = null;
				if(list.size() > 0) {
					for(MultipartFile mf : list) {
						if (mf.getSize() > 0) {
								uploadFile = ufp.uploadFileRename(upPathAttach, mf.getOriginalFilename(), mf.getBytes());
								service.insertAttachFile(uploadFile, n.getNo());
						}						
					}
				}
			}else {
				System.out.println("새로운 첨부파일 등록 없음");
			}
			if(oldImgName != null) {
				ifhl.fileDelete(upPathImg, oldImgName);
			}else {
				System.out.println("이미지 변경 없음");
			}	
			if(oldAttachFileName != null) {
				for(String fn : oldAttachFileName) {
					int attachFileNo = 0;
					
						if(fn.split("/")[4].split("_")[0].equals("thumb")) {			
							attachFileNo = service.getAfByThumbFn(fn);
						}else {
							attachFileNo = service.getAfByNoImgFn(fn);
						}				
						service.deleteOldAttachFile(attachFileNo);
						ifhl.fileDelete(upPathAttach, fn);	
				}
			}else {
				System.out.println("첨부파일 삭제 없음");
			}
			service.updateNoticeText(n);
			rttr.addFlashAttribute("result", "success");	
		} catch (Exception e) {
			rttr.addFlashAttribute("result", "fail");
			e.printStackTrace();
		}
		return "redirect:/notice/viewContent?no="+n.getNo();
	}
	
	@RequestMapping("deleteNotice")
	public String deleteNotice(@RequestParam int no, RedirectAttributes rttr, HttpServletRequest request) {
		System.out.println("삭제할 게시물"+no);
		
		String upPathImg = request.getSession().getServletContext().getRealPath("resources/uploads/noticeBoardImg/");
		String upPathAttach =  request.getSession().getServletContext().getRealPath("resources/uploads/attachFile");
		
		ImageFileHandling ifh = new ImageFileHandling();
		
		int result = 0;
		try {
			result = service.deleteNotice(no, upPathImg, upPathAttach);
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
			
				
				if (af.getThumbnailFile() != null) {

					System.out.println(af.getThumbnailFile());
					ifh.fileDelete(upPathAttach, af.getThumbnailFile());
					
				}
				ifh.fileDelete(upPathAttach, af.getOriginFile());
				
			}
		}
		System.out.println(targetFile);
		ifh.fileDelete(upPathImg, targetFile);
		
			result = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return result;
	}


}
