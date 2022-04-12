package com.bookdabang.khn.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.EventBoardVo;
import com.bookdabang.common.domain.EventReplyVo;
import com.bookdabang.common.domain.ReportBoard;
import com.bookdabang.common.etc.IPCheck;
import com.bookdabang.khn.etc.UploadFile;
import com.bookdabang.khn.service.EventService;

@Controller
@RequestMapping(value = "/event/*")
// event 하위 요청을 처리하는 컨트롤러임을 명시
public class EventBoardController {
	
	@Inject
	private EventService service;
	
	private List<UploadFile> upfileLst = new ArrayList<UploadFile>(); // 업로드된 파일들의 리스트
	

	// reading-----------------------------------------------------------
	// GET방식으로 통신하여 들어오는 이벤트 하위, 전체 리스트를 불러오는 기능을 작성
	@RequestMapping(value = "/allEventList", method = RequestMethod.GET) 
	public String allEventList(Locale locale, Model model) throws Exception {
		System.out.println("전체 이벤트 목록을 불러옵니다");
		List eventBoardList = service.allEventList();
		model.addAttribute("eventBoardList", eventBoardList);
		
		return "/event/allEventList";
	}
	
	@RequestMapping(value = "/detailEvent", method = RequestMethod.GET)
	public String readEvent(@RequestParam("boardno") String boardno, Model model, HttpServletRequest request) throws Exception {
		int no = Integer.parseInt(boardno); //넘겨온 글번호를 int로 변환하여 저장
		String ipAddr = null; // ip주소를 저장할 변수 생성
		System.out.println(no + "번 게시글의 상세 페이지를 띄웁니다");
		
		ipAddr = IPCheck.getIPAddr(request); // 리퀘스트를 요청한 ip주소를 체크하여 ipaddr에 저장
		Timestamp lastConnection = service.pageViewCheck(ipAddr, no); // 해당 게시글(no)에 접근한 마지막 시간을 체크
		
		
		
		EventBoardVo detailEvent = service.readDetailEvent(no);
		model.addAttribute("detailEvent", detailEvent);
		
		return "/event/detailEvent";
		
	}
	
	// 베스트 게시글
	@RequestMapping(value = "/allBestList", method = RequestMethod.GET)
	public String allBestList(Locale locale, Model model) throws Exception {
		System.out.println("베스트 게시글을 불러옵니다");
		List allBestList = service.allBestList();
		model.addAttribute("allBestList", allBestList);
		
		return "/event/allBestList";
	}
	
	
	// insert-----------------------------------------------------------
	@RequestMapping(value = "/showinsertEventPage")
	public String showinsertEventPage() {
		System.out.println("글쓰기 페이지로 이동합니다.");
		return "/event/insertEvent";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertEvent", method = RequestMethod.POST)
	public String insertEvent(EventBoardVo newEvent, RedirectAttributes rttr) throws Exception  {
		String result = "";
		System.out.println("글을 등록합니다.");
		
		if (service.insertEvent(newEvent)) {
			result = "redirect:/event/allEventList";
		} else {
			result = "redirect:/event/insertEvent";
		}

		return result; // 기존 페이지로 이동
		
	}
	
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	public String reply(EventReplyVo newReply, RedirectAttributes rttr) throws Exception {
		System.out.println("댓글을 남깁니다");
		
		boolean EventReply = service.insertReply(newReply);
		
		return null;
	}
	
	
	// delete-----------------------------------------------------------
	@RequestMapping(value = "/eventDel")
	public String deleteEvent(@RequestParam("boardno") String boardno, Model model, HttpServletRequest request) throws Exception {
		int no = Integer.parseInt(boardno);
		System.out.println(no + "번 게시글을 삭제합니다");
		
		int deleteEvent = service.deleteEvent(no);
		
		return "redirect:/event/allEventList";
	}
	
	
	
	// update-----------------------------------------------------------
	@RequestMapping(value = "/eventUpdatePage") // 업데이트 페이지로 이동
	public String eventUpdatePage(@RequestParam("boardno") String boardno, Model model, HttpServletRequest request) throws Exception {
		int no = Integer.parseInt(boardno);
		EventBoardVo detailEvent = service.readDetailEvent(no);
		model.addAttribute("detailEvent", detailEvent);
		
		return "/event/upDateEvent";
	}
	
	
	@RequestMapping(value = "/eventUpdate", method = RequestMethod.GET) // 실제 업데이트 로직
	public String eventUpdate(@RequestParam("boardno") String boardno, EventBoardVo updateEvent, RedirectAttributes rttr) throws Exception {
		String result = "";
		int no = Integer.parseInt(boardno);
		System.out.println(no + "번 게시글을 업데이트합니다");
		
		if (service.updateEvent(updateEvent)) {
			System.out.println("업데이트 성공");
			rttr.addFlashAttribute("result", "success");
			result = "redirect:/event/detailEvent?" + no;
		} else {
			System.out.println("업데이트 실패");
			rttr.addFlashAttribute("result", "fail");
			result = "redirect:/event/upDateEvent";
		}
	
		return result;
	}
}
