package com.bookdabang.lbr.etc;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaConfirm {
private static Map<String, MediaType> mediaMap;
	
	{
		// 인스턴스 멤버를 초기화 하는 코드를 작성 -> 생성자에게 할 수 있으므로 잘 사용하지 않는다.
	}
	
	static { // 현재클래스의 멤버중 static 멤버를 초기화 할 수 있는 코드를 작성하는 블록
		mediaMap = new HashMap<String, MediaType>();
		
		// 이미지 파일형식을 map에 넣어두고, map에 없는 확장자 => 이미지가 아니다
		mediaMap.put("jpg", MediaType.IMAGE_JPEG);
		mediaMap.put("gif", MediaType.IMAGE_GIF);
		mediaMap.put("png", MediaType.IMAGE_PNG);
		mediaMap.put("jpeg", MediaType.IMAGE_JPEG);
		mediaMap.put("jfif", MediaType.IMAGE_JPEG);
	}
	
	
	/**
	 * @Method Name : getMediaType
	 * @작성일 : 2022. 3. 15.
	 * @작성자 : goo06
	 * @변경이력 : 
	 * @Method 설명 : 업로드 된 파일의 확장자를 받아 그 파일의 MediaType 반환
	 */
	public static MediaType getMediaType(String ext) {
		return mediaMap.get(ext);
		
	}
}
