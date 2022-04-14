package com.bookdabang.lbr.etc;

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





public class BoardUploadFileProcess {
	private BoardUploadFile uploadFile = new BoardUploadFile();
	
	
	public BoardUploadFile uploadFileRename(String upPath, String originalFilename, byte[] file) throws IOException {
		
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid.toString() + "_" + originalFilename; // 같은이름파일이여도 겹칠일이 없다..
		String savePath = upPath + calculateSavePath(upPath); // 파일이 저장될 경로 계산
		File target = new File(savePath + File.separator, saveFileName);
		FileCopyUtils.copy(file, target); // 파일 저장
		
		this.uploadFile.setOriginalFileName(((savePath + File.separator + saveFileName).substring(upPath.length())).replace(File.separator, "/"));
		
		String ext = originalFilename.substring(originalFilename.lastIndexOf(".") +1); // 확장자
		if(MediaConfirm.getMediaType(ext.toLowerCase()) != null) { // 이미지 파일
			// 이미지파일일 경우 -> 이미지 사이즈를 줄여 반환
			
			makeTumbnail(upPath, savePath, saveFileName);
			
		}else {
			// 이미지 파일이 아닐경우
			String fileName = savePath + File.separator + saveFileName;
			
			this.uploadFile.setNotImageFileName(fileName.substring(upPath.length()).replace(File.separator, "/"));
			
		}
		
		// DB테이블의 저장될 경로 + 이름 이자, 태그에 사용될 경로 + 이름
		System.out.println(this.uploadFile.toString());
		
		return this.uploadFile;
		
	}

	
	private void makeTumbnail(String upPath, String savePath, String saveFileName) throws IOException {
		String originalFileName = savePath + File.separator + saveFileName;
		System.out.println("원본 파일 이름 :  "+originalFileName);
		
		BufferedImage originFile = ImageIO.read(new File(originalFileName));
		
		int heightOfOriginFile = originFile.getHeight();
		BufferedImage destFile = null;
		if(heightOfOriginFile > 100) {// 높이 100px 기준으로 resize
			 destFile = Scalr.resize(originFile, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		} else {
			destFile = originFile; // 높이 100px미만이면 resize하지 않는다
		}
		
		
		
		String thumbnailImageFileName = savePath + File.separator + "thumb_" + saveFileName; // 썸네일 파일의 이름
		
		File newTumbnailFile = new File(thumbnailImageFileName);
		// 썸네일 파일 저장
		ImageIO.write(destFile, thumbnailImageFileName.substring(thumbnailImageFileName.lastIndexOf(".")+1), newTumbnailFile);
		
		this.uploadFile.setThumbnailFileName(
				thumbnailImageFileName.substring(upPath.length()).replace(File.separator, "/"));
		
		
	}
	
	public String calculateSavePath(String upPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator + cal.get(Calendar.YEAR)+ ""; // \2022 
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1); // \2022\03
		String dataPath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // \2022\03\15
		System.out.println(dataPath);
		
		makeDir(upPath, yearPath, monthPath, dataPath);
		
		return dataPath;
		
	}
	
	private void makeDir(String upPath, String... paths) {
		// String... : 가변인자 배열로 받은것이라고 컴파일러에게 알려줌. yearPath, monthPath, dataPath의 값을 배열로 넘겨줌
		System.out.println(Arrays.toString(paths)); // 배열로 전달받은 것 확인
		
		if(new File(upPath + paths[paths.length -1]).exists()) { // paths.length -1 : \2022\03\15
			// 해당경로가 존재한다면... 폴더를 생성할 필요가 없다.
			return; // 호출한 곳으로 돌아감
		}
		
		for(String path : paths) {
			File dirPath = new File(upPath + path);
			
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}

