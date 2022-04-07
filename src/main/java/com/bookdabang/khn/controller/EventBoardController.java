package com.bookdabang.khn.controller;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.EventBoardVO;
import com.bookdabang.khn.service.EventService;

@Controller
@RequestMapping(value = "/event/*")
// event 하위 요청을 처리하는 컨트롤러임을 명시
public class EventBoardController {
	
	@Inject
	private EventService service;
	
	// reading-----------------------------------------------------------
	// GET방식으로 통신하여 들어오는 이벤트 하위, 전체 리스트를 불러오는 기능을 작성
	@RequestMapping(value = "/allEventList", method = RequestMethod.GET) 
	public void allEventList(Locale locale, Model model) throws Exception {
		System.out.println("전체 이벤트 목록을 불러옵니다");
		List eventBoardList = service.allEventList();
		model.addAttribute("eventBoardList", eventBoardList);
	}
	
	@RequestMapping(value = "/readEvent", method = RequestMethod.GET)
	public void readEvent() {
		
	}
	
	
	// insert-----------------------------------------------------------
	@RequestMapping(value = "/showinsertEventPage")
	public String showinsertEventPage() {
		System.out.println("글쓰기 페이지로 이동합니다.");
		return "/event/insertEvent";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertEvent", method = RequestMethod.POST)
	public String insertEvent(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		return null;
	}
	
}
