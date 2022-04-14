package com.bookdabang.khn.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bookdabang.common.domain.EventReplyVo;
import com.bookdabang.khn.service.EventService;

@Controller
@RequestMapping(value = "/eventReply/*")
public class EventReplyController {
	
	@Inject
	private EventService service;
	
	
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	public String reply(EventReplyVo newReply, RedirectAttributes rttr, Model model) throws Exception {
		System.out.println("댓글을 남깁니다");

		boolean EventReply = service.insertReply(newReply);
		model.addAttribute("EventReply", EventReply);
		return "redirect:/event/detailEvent";

	}
}
