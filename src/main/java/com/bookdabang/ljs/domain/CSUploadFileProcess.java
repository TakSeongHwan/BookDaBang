package com.bookdabang.ljs.domain;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

import com.bookdabang.common.etc.MediaConfirm;

public class CSUploadFileProcess {
	private CSUploadFile uploadFile = new CSUploadFile();

	// 업로드된 파일 : byte[]
	// 업로드된 파일의 오리지널 이름.
	public CSUploadFile uploadFileRename(String upPath, String originalFileName, byte[] file) throws IOException {
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid.toString() + "_" + originalFileName;
		String savePath = upPath + calculateSavePath(upPath); // 파일이 저장될 경로 계산
		
		File target = new File(savePath + File.separator, saveFileName); // 파일을 저장하는 객체.
		
		System.out.println("프로세스 : 타겟 파일 잘 찍히나" + target.toString());
		
		FileCopyUtils.copy(file, target); // FileCopyUtils - 스프링에서 제공하는 객체. 파일 저장되는 코드.
		
		this.uploadFile.setOriginFile((savePath + File.separator + saveFileName).substring(upPath.length()).replace(File.separator, "/"));
		
		
		// 썸네일(Thumbnail)을 만들자.
		String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1); // 확장자 가져오기
		
		if(MediaConfirm.getMediaType(ext.toLowerCase()) != null) { // 이미지 파일이면
			// 이미지 파일일 경우 -> 이미지 사이즈를 줄여 (섬네일 만드는) 반환하는 메소드 호출_ImgScalr 라이브러리 이용.
			
			makeThumbnail(upPath, savePath, saveFileName);
			
		} else { // 이미지 파일이 아닐 경우
			
			String fileName = savePath + File.separator + saveFileName;
			
			this.uploadFile.setNotImageFile(fileName.substring(upPath.length()).replace(File.separator, "/"));
			System.out.println("프로세스 : 이미지 파일 아닐 경우 이름 : " + this.uploadFile.getNotImageFile());
			
		}
		 
		// DB 테이블에 저장될 경로 + 이름이자, 태그에 사용될 경로 + 이름
		
		return this.uploadFile;
	}

	private void makeThumbnail(String upPath, String savePath, String saveFileName) throws IOException {
		String originalFileName = savePath + File.separator + saveFileName;
		System.out.println("원본 파일 이름 : " + originalFileName);
		
		 BufferedImage originFile = ImageIO.read(new File(originalFileName));
	      
	      int heightOfOriginFile = originFile.getHeight();
	      
	      BufferedImage destFile = null;
	      
	      if(heightOfOriginFile > 100) {// 높이 100px 기준으로 resize
	    	  
	          destFile = Scalr.resize(originFile, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
	          
	      } else {
	         destFile = originFile; // 높이 100px미만이면 resize하지 않는다
	      }
	      System.out.println(savePath);
		// 높이 100px 기준으로 resize
		String thumbnailImageFileName = savePath + File.separator + "thumb_" + saveFileName; // 썸네일 파일의 이름
		
		File newThumbnailFile = new File(thumbnailImageFileName);
		// 썸네일 파일 저장
		ImageIO.write(destFile, thumbnailImageFileName.substring(thumbnailImageFileName.lastIndexOf(".") + 1), newThumbnailFile);
		
		this.uploadFile.setThumbnailFile(thumbnailImageFileName.substring(upPath.length()).replace(File.separator, "/"));
	}

	public String calculateSavePath(String upPath) {
		Calendar cal = Calendar.getInstance();
		
		// 날짜로 저장할 경로 만들기
		String yearPath = File.separator + cal.get(Calendar.YEAR) + ""; // \2022
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+ 1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); //
		
		System.out.println(datePath);
		
		// 폴더 만들기
		makeDir(upPath, yearPath, monthPath, datePath);
		
		return datePath;
		
		
	}
// 폴더 만드는 메소드
	private void makeDir(String upPath, String... paths) {
		// String... : 가변인자 배열로 받은 것이라고 컴파일러에게 알려줌. upPath, yearPath, monthPath, datePath의 값을 배열로 넘겨줌
		System.out.println(Arrays.toString(paths));
		// 파일객체 넘겨주면서 경로 설정
		if (new File(upPath + paths[paths.length -1]).exists()) { // = 해당 경로가 존재한다면
			// 해당 경로가 존재하면? -> 폴더를 생성할 필요가 없다. return 시킴.
			return;
		}
		for (String path : paths) {
			File dirPath = new File(upPath + path);
			
			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}
