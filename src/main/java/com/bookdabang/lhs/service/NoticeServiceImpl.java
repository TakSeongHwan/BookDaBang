package com.bookdabang.lhs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.lhs.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Inject 
	NoticeDAO noticeDAO;
}
