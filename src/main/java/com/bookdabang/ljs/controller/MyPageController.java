package com.bookdabang.ljs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.RecentSeenProd;
import com.bookdabang.common.domain.ReviewVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.service.LoginService;
import com.bookdabang.ljs.service.MyPageService;

@Controller
@RequestMapping("/mypage/*")
public class MyPageController {
	
	@Inject
	private LoginService service;
	
	
	@Inject
	private MyPageService myPgService;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String myPageHome(@RequestParam("u") String sessionId, Model model) {
		
		MemberVO loginMember = null;
		System.out.println(sessionId);
		List<RecentSeenProd> recSeenProd = null;
		try {
			
			loginMember = service.findLoginSess(sessionId); // 세션아이디로 멤버 찾기.
			
			String userId = loginMember.getUserId();
			System.out.println("마이페이지 로딩시 유저아이디 잘 가져오나?" + userId);
			recSeenProd = myPgService.showRecentSeenProd(userId);
			
			
		} catch (Exception e) {
			System.out.println("세션값으로 멤버 찾기 실패하였습니당");
		}
		
		model.addAttribute("loginMember", loginMember);
		model.addAttribute("recentSeenProd", recSeenProd);
		
		
		return "mypage/memberinfo";
	}
	
	
	
	
	
	@RequestMapping(value = "viewPoint", method = RequestMethod.GET)
	public ResponseEntity<List<MemberPoint>> pointCheck(@RequestParam("ses") String sessionId) {
		
				MemberVO loginMember = null;
				ResponseEntity<List<MemberPoint>> result = null;
				List<MemberPoint> pointHistory = null;
					try {
						loginMember = service.findLoginSess(sessionId);
						String userId = loginMember.getUserId();
						pointHistory = service.pointCheck(userId);
						result = new ResponseEntity<List<MemberPoint>>(pointHistory, HttpStatus.OK);
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						result = new ResponseEntity<List<MemberPoint>>(HttpStatus.BAD_REQUEST);
						System.out.println("포인트 적립 세션아이디 에러");
					}
				return result;
	}
	
	@RequestMapping(value = "/pointTotal", method = RequestMethod.GET)
	public ResponseEntity<List<MemberPoint>> viewPointTotal(@RequestParam("u") String sessionId) {
		
		MemberVO loginMember = null;
		
		ResponseEntity<List<MemberPoint>> result = null;
		List<MemberPoint> myTotalPoint = null;
		
			try {
				loginMember = service.findLoginSess(sessionId);
				String userId = loginMember.getUserId();
				myTotalPoint=  myPgService.showTotalPoint(userId);
				result = new ResponseEntity<List<MemberPoint>>(myTotalPoint, HttpStatus.OK);
				
				
			} catch (Exception e) {
				
				e.printStackTrace();
				result = new ResponseEntity<List<MemberPoint>>(HttpStatus.BAD_REQUEST);
				System.out.println("전체 포인트 뷰 에러");
			}
			
		
		System.out.println(sessionId +"세션아이디 받아옴");
		return result;
 
		}
	
	
	@RequestMapping(value = "mylike", method = RequestMethod.GET)
	@ResponseBody
	public List<FreeBoard> myLikeAndRe(@RequestParam("u") String sessionId) {
		
		MemberVO loginMember = null;
		List<FreeBoard> lstMyLikeF = null;
		try {
			
			loginMember = service.findLoginSess(sessionId);
			String userId = loginMember.getUserId();
			lstMyLikeF =  myPgService.showMyLike(userId);
			
			
		} catch (Exception e) {	
			System.out.println("자게 좋아요 통신 실패");
			e.printStackTrace();
		}
		
		return lstMyLikeF;
				
	}
	
	
	
	@RequestMapping(value = "withdrawMember", method = RequestMethod.POST)
	@ResponseBody
	public int withdrawMember(@RequestParam("ses") String memberSess) {
		
				System.out.println(memberSess + " 탈퇴시키러 여기에 올까요?");
				
				int result = 0;
				try {
					result = service.withdrawMember(memberSess);	 
					
				if(result == 1) {
					System.out.println("탈퇴 성공하였습니다.");
				}
					
				
				} catch (Exception e) {
					
					e.printStackTrace();
					System.out.println("탈퇴 실패하였습니다.");
					
				}
				
				return result;
	}
	
	public List<RecentSeenProd> showRecentSeenProd(String userId) {
		
		List<RecentSeenProd> rsProds = null;
		try {
			rsProds =  myPgService.showRecentSeenProd(userId);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("최근 본 상품들 리스트 받아오기 실패");
		}
	
		return rsProds;
	}
	
	@RequestMapping(value = "changePassword", method = RequestMethod.POST)
	@ResponseBody
	public int modifyPassword(@RequestParam("pwd1") String newPwd, @RequestParam("ses") String sessionId) {
		int result = 0;
		
		try {
			
			MemberVO loginMember = service.findLoginSess(sessionId); // 멤버에 넣어주고
			
			String userId = loginMember.getUserId(); // 유저아이디 받아와서
			System.out.println("modifyPwd_현재 세션으로 유저아이디 받아왔는지 확인. 유저 아이디 : " + userId);
			
			LoginDTO passwordID = new LoginDTO(userId, newPwd, false, null);
			result = myPgService.modifyPassword(passwordID);
			System.out.println("성공 여부 : " + result);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value = "confirmPassword", method = RequestMethod.POST)
	@ResponseBody
	public boolean confirmPassword(@RequestParam("oldPwd") String oldPwd, @RequestParam("ses") String sessionId) {
		boolean result = false;
		
		
		try {
			MemberVO loginMember = service.findLoginSess(sessionId); // 멤버에 넣어주고
			LoginDTO dto = new LoginDTO(loginMember.getUserId(), oldPwd, false, sessionId); 
			// loginDTO에 넣어서 로그인 프로세스를 그대로 써도 될거 같기도 한데
			
			MemberVO resultConfirmPwd = service.login(dto); 
			
			if (resultConfirmPwd != null) { // 맞다는 뜻
				System.out.println(resultConfirmPwd.toString());
				result = true;
				
			} else { // 아니라는 뜻
				
				result = false;
			}
			
			System.out.println(result);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@RequestMapping(value = "/myposts", method = RequestMethod.GET)
	@ResponseBody
	public List<FreeBoard> showMyPostsFree(@RequestParam("u") String sessionId) {
		
		
		System.out.println(sessionId);
		
			MemberVO loginMember = null;
			List<FreeBoard> myPostsFree = null;
			
			try {
				
				loginMember = service.findLoginSess(sessionId);
				String userId = loginMember.getUserId();
				System.out.println(userId);
				// 유저아이디로 자유게시판 불러오기
				  myPostsFree = myPgService.myFreeLst(userId);
				  
				  
	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
				System.out.println("통신 실패");
			} 
			

			return myPostsFree;
		}
	
	
	@RequestMapping(value = "/myreviews", method = RequestMethod.GET)
	@ResponseBody
	public List<ReviewVO> showMyReviews(@RequestParam("u") String sessionId) {
		
		System.out.println(sessionId);
		
			MemberVO loginMember = null;
			List<ReviewVO> myReviews = null;
			
			try {
				
				loginMember = service.findLoginSess(sessionId);
				String userId = loginMember.getUserId();
				System.out.println(userId);
				// 유저아이디로 자유게시판 불러오기
				myReviews = myPgService.myReviewLst(userId);
				  
	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
				System.out.println("통신 실패");
			} 
			

			return myReviews;
		}
	
	
	@RequestMapping(value = "/myqna", method = RequestMethod.GET)
	@ResponseBody
	public List<ProductQnA> showMyQnA(@RequestParam("u") String sessionId) {
		
		System.out.println(sessionId);
		
			MemberVO loginMember = null;
			List<ProductQnA> myQnAs = null;
			
			try {
				
				loginMember = service.findLoginSess(sessionId);
				String userId = loginMember.getUserId();
				System.out.println(userId);
				// 유저아이디로 QnA게시판 불러오기
				myQnAs = myPgService.myQnALst(userId);
				  
	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
				System.out.println("통신 실패");
			} 
			

			return myQnAs;
		}
	
	
	@RequestMapping(value = "/mycsposts", method = RequestMethod.GET)
	@ResponseBody
	public List<CustomerService> showMyCS(@RequestParam("u") String sessionId, Model model) {
		
		System.out.println("문의글 테스트 " + sessionId);
		
			MemberVO loginMember = null;
			List<CustomerService> myCSPosts = null;
					
			try {
				loginMember = service.findLoginSess(sessionId);
				String userId = loginMember.getUserId();
				System.out.println(userId);	
				
				myCSPosts = myPgService.myCSLst(userId);
	
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
		
			return myCSPosts;
		}
	
	
	@RequestMapping(value = "/delmycs", method = RequestMethod.GET)
	@ResponseBody
	public int delMyCS(@RequestParam(value = "postArr[]") List<Integer> postNo) {
		
		
		int result = 0;
				try {
					
					result = myPgService.delMyCSPosts(postNo);
					
				} catch (Exception e) {
					
					System.out.println("실패여유");
					e.printStackTrace();
				}
		
				
		
			return result;
		}
	

	
	
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public void home(@RequestParam("ses") String sessionId) {
//		
//	}
	
	
}
