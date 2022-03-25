package com.bookdabang.lhs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookdabang.lhs.service.ChartService;

@Controller
@RequestMapping("/saleschart/*")
public class SalesChartController {
	@Inject
	ChartService service;
}
