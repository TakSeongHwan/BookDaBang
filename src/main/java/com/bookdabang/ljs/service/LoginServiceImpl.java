package com.bookdabang.ljs.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.ljs.domain.LoginDTO;
import com.bookdabang.ljs.persistence.LoginDAO;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Inject
	private LoginDAO mdao;
	
	
	@Override
	public MemberVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return mdao.login(dto);
	}


	@Override
	public int withdrawMember(String userId) throws Exception {
		// TODO Auto-generated method stub
		return mdao.withdrawMember(userId);
	}


	@Override
	public int lastLogin(LoginDTO dto) throws Exception {
		
		return mdao.lastLogin(dto); 
		
	}


	@Override
	public MemberVO findLoginSess(String sessionId) throws Exception {
		
		return mdao.findLoginSess(sessionId);
	}


	@Override
	public List<MemberPoint> pointCheck(String userId) throws Exception {
		
		return mdao.pointCheck(userId);
	}
	@Override
	public String getAccessToken (String authorize_code) {
		
			String access_Token = "";
			String refresh_Token = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";

			try {
				URL url = new URL(reqURL);
	            
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            
				conn.setRequestMethod("POST");
				conn.setDoOutput(true);
				// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				StringBuilder sb = new StringBuilder();
				sb.append("grant_type=authorization_code");
				sb.append("&client_id=95a72bf8adefb359efc8431a1b86586d"); //본인이 발급받은 key
				sb.append("&redirect_uri=http://localhost:8001/kakaoLogin"); // 본인이 설정한 주소 
				sb.append("&code=" + authorize_code);
				bw.write(sb.toString());
				bw.flush();
	            
				// 결과 코드가 200이라면 성공
				int responseCode = conn.getResponseCode();
				System.out.println("responseCode : " + responseCode);
	            
				// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String result = "";
	            
				while ((line = br.readLine()) != null) {
					result += line;
				}
				System.out.println("response body : " + result);
	            
				// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
				JsonParser parser = new JsonParser();
				JsonElement element = parser.parse(result);
	            
				access_Token = element.getAsJsonObject().get("access_token").getAsString();
				refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
	            
				System.out.println("access_token : " + access_Token);
				System.out.println("refresh_token : " + refresh_Token);
	            
				br.close();
				bw.close();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			return access_Token;
		}
		
		public HashMap<String, Object> getUserInfo(String access_Token) {
			
			HashMap<String, Object> userInfo = new HashMap<String, Object>();
			String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			String id = element.getAsJsonObject().get("id").getAsString();
			String dateConnected = element.getAsJsonObject().get("connected_at").getAsString(); 
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString(); 
			String userImg = kakao_account.getAsJsonObject("profile").get("thumbnail_image_url").getAsString();
					
			
	
			MemberVO user = new MemberVO();
			
			user.setUserId(id);
			user.setUserEmail(email);
			user.setNickName(nickname);
			user.setUserName(nickname);
			user.setGender(kakao_account.get("gender").getAsString());
			
			//user.setLastLogin(dateConnected);
			
			userInfo.put("user", user);
			userInfo.put("userImg", userImg);
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}	
	
	
				
	}





