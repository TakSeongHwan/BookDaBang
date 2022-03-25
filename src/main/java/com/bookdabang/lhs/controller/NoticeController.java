package com.bookdabang.lhs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookdabang.lhs.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	@Inject
	NoticeService service;
}
