package com.bookdabang.lhs.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.Notice;
import com.bookdabang.common.etc.UploadFileProcess;
import com.bookdabang.lhs.etc.ImageFileHandling;
import com.bookdabang.lhs.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Inject 
	NoticeService service;
	
	private List<AttachFileVO> fileList = new ArrayList<AttachFileVO>();

	@RequestMapping("listAll")
	public String notice(Model m) {
		List<Notice> notice = new ArrayList<Notice>();
		notice = service.entireNotice();
		m.addAttribute("notice",notice);
		return "notice/notice";
	}
	
	@RequestMapping("viewContent")
	public void showNoticeContent(Model m, @RequestParam("no") int no) {
		System.out.println(no);
		Notice content = service.getContentByNo(no);
		System.out.println(content);
		m.addAttribute("content", content);
	}
	
	@RequestMapping("insertNotice")
	public void showNoticeWritePage() {
		
	}
	
	@RequestMapping(value="insertNotice",method=RequestMethod.POST)
	public void insertNotice(Notice n) {
	System.out.println(n);	
	}
	
	@RequestMapping(value="imageHandling", method=RequestMethod.POST)
	public ResponseEntity<String> imageHandling(MultipartFile imageFile, HttpServletRequest request) {
		
		long maxFileSize = 1024 * 1024 * 10;

		ResponseEntity<String> result = null;
		
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads/noticeBoardImg");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);
		
		long fileSize = imageFile.getSize();
		String orgFileName = imageFile.getOriginalFilename();
		
		ImageFileHandling ifh = new ImageFileHandling();
		String newFileName = null;
			if(fileSize <= maxFileSize) {
				
				try {
					newFileName = ifh.fileRenaming(orgFileName);
					ifh.fileUploading(newFileName, upPath, imageFile.getBytes());
			
					System.out.println(newFileName);
					result = new ResponseEntity<String>(newFileName, HttpStatus.OK);
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					result = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
					e.printStackTrace();
				}
				
			}
			System.out.println(result);
			System.out.println("올라간 파일 : "+ newFileName);
			return result;


		
			
	}
	
	@RequestMapping(value="attachFileHandling", method=RequestMethod.POST)
	public ResponseEntity<AttachFileVO> attachFileHandling(MultipartFile upfile, HttpServletRequest request) {
		System.out.println("컨트롤러단!");
		
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads/attachFile");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);
		AttachFileVO uploadFile = null;
		
		ResponseEntity<AttachFileVO> result = null;
		System.out.println(upfile);
		if(upfile.getSize()>0) {
			
			UploadFileProcess ufp = new UploadFileProcess();
			
			try {
				uploadFile = ufp.uploadFileRename(upPath, upfile.getOriginalFilename(), upfile.getBytes());
				this.fileList.add(uploadFile);
				result = new ResponseEntity<AttachFileVO>(uploadFile, HttpStatus.OK);//UploadFile객체와 통신 정상종료 사인 보냄

			} catch (IOException e) {
				result = new ResponseEntity<AttachFileVO>(HttpStatus.BAD_REQUEST);//통신 실패 사인을 보낸다
				e.printStackTrace();
			}	
		}
		return result;
	}
	
	
}
