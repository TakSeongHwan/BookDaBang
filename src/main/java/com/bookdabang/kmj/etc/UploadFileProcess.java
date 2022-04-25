package com.bookdabang.kmj.etc;

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

public class UploadFileProcess {
	
	private UploadFile uploadFile = new UploadFile();
	
	/**
	 * @Method Name : uploadFileRename
	 * @작성일 : 2022. 4. 19
	 * @작성자 : 강명진
	 * @변경이력 : 
	 * @param upPath : 업로드 되는 파일의 경로
	 * @param originalFileName : 업로드 된 파일의 원본명
	 * @param file : 업로드된 파일 (byte[])
	 * @throws IOException 
	 * @Method 설명 : 저장되는 파일명 새로 만드는 메서드
	 */
	public UploadFile uploadFileRename(String upPath, String orginalFileName, byte[] file) throws IOException {
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid.toString() + "_" + orginalFileName;
		String savePath = upPath + calculateSavePath(upPath); // 파일이 저장될 경로 계산
		File target = new File(savePath + File.separator, saveFileName);
		FileCopyUtils.copy(file, target); // 파일 저장
		
		this.uploadFile.setOriginalFileName(((savePath + File.separator + saveFileName).substring(upPath.length())).replace(File.separator, "/"));
		
		// 썸네일(Thumbnail) 생성
		String ext = orginalFileName.substring(orginalFileName.lastIndexOf(".")+ 1); // 확장자
		
		if(MediaConfirm.getMediaType(ext.toLowerCase()) != null) {
			// 이미지 파일일 경우 -> 이미지 사이즈를 줄여 반환
			makeThumnail(upPath, savePath, saveFileName);	
		} else {
			// 이미지 파일이 아닐경우
			String fileName = savePath + File.separator + saveFileName;
			this.uploadFile.setNotImageFileName(fileName.substring(upPath.length()).replace(File.separator, "/"));
		}
		// DB 테이블에 저장될 경로 + 이름이자, 태그에 사용될 경로 + 이름
		 
		return this.uploadFile;
		
	}
	
	/**
	 * @throws IOException 
	 * @Method Name : makeThumnail
	 * @작성일 : 2022. 4. 19.
	 * @작성자 : 강명진
	 * @변경이력 : 
	 * @Method 설명 : ImgScalr를 이용하여 이미지 썸네일을 만들어 저장
	 */
	private void makeThumnail(String upPath, String savePath, String saveFileName) throws IOException {
		String originalFileName = savePath + File.separator + saveFileName; 
		System.out.println("원본 파일 이름  :" + originalFileName);
		
		BufferedImage originFile = ImageIO.read(new File(originalFileName));
		// 높이 100px 기준으로 resize
		
		int heightOfOriginFile = originFile.getHeight();
		BufferedImage destFile = null;
		if(heightOfOriginFile > 100) {// 높이 100px 기준으로 resize
			 destFile = Scalr.resize(originFile, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		} else {
			destFile = originFile; // 높이 100px미만이면 resize하지 않는다
		}
		
		String thumbnailImageFileName = savePath + File.separator + "thumb_" + saveFileName; //썸네일 파일의 이름
		
		// 썸네일 파일 저장
		File newThumbnailFile  = new File(thumbnailImageFileName);
		ImageIO.write(destFile, thumbnailImageFileName.substring(thumbnailImageFileName.lastIndexOf(".") + 1), newThumbnailFile);
		
		this.uploadFile.setThumbnailFileName(thumbnailImageFileName.substring(upPath.length()).replace(File.separator, "/"));
		
	}
	
	/**
	 * @Method Name : calculateSavePath
	 * @작성일 : 2022. 4. 19
	 * @작성자 : 강명진
	 * @변경이력 : 
	 * @Method 설명 : 파일이 실제 저장되는 경로 계산
	 * 				  파일을 폴더에 저장시, 폴더는 "/resources/uploads/년/월/일" 식으로 만들어져 저장 
	 */
	public String calculateSavePath(String upPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator + cal.get(Calendar.YEAR) + ""; // \2022
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // \2022\03
		String datePath = monthPath + File.separator  + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // \2022\03\15
		System.out.println("파일 저장 경로계산 : " + datePath);
		
		makeDir(upPath, yearPath, monthPath, datePath);
		
		return datePath;
	}
	
	/**
	 * @Method Name : makeDir
	 * @작성일 : 2022. 4. 19
	 * @작성자 : 강명진
	 * @변경이력 : 
	 * @Method 설명 : 넘겨받은 upPath 하위에 yearPath\monthPath\datePath 구조의 폴더 생성
	 */
	private void makeDir(String upPath, String...paths) {
		// String... : 가변인자 배열로 받은 것이라고 컴파일러에게 알려줌. yearPath, monthPath, datePath의 값을 배열로 넘겨줌
		System.out.println(Arrays.toString(paths));
		
		if(new File(upPath + paths[paths.length-1]).exists()) {
			// 해당 경로가 존재한다면 폴더를 생성할 필요가 없다.
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
