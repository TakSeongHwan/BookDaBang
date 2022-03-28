package com.bookdabang.lhs.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookdabang.common.domain.Notice;
import com.bookdabang.lhs.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Inject 
	NoticeService service;

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
	
}
