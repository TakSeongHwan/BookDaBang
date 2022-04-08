package com.bookdabang.common.etc;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaConfirm {
	private static Map<String, MediaType> mediaMap;
	static {
		
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("jpg", MediaType.IMAGE_JPEG);
		mediaMap.put("jpeg", MediaType.IMAGE_JPEG);
		mediaMap.put("jfif", MediaType.IMAGE_JPEG);
		mediaMap.put("gif", MediaType.IMAGE_GIF);
		mediaMap.put("png", MediaType.IMAGE_PNG);
		
	}
	
	/**
	 * @Method name : getMediaType
	 * @작성일 : 2022. 3. 25.
	 * @작성자 : 이한솔
	 * @변경이력 : 
	 * @Method 설명: 파일 업로드시 업로드된 파일의 확장자를 받아 해당 파일의 MediaType을 반환
	 */
	public static MediaType getMediaType(String ext) {
		return mediaMap.get(ext);
		
	}
}
