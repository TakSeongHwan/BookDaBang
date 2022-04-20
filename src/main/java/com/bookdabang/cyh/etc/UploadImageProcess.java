package com.bookdabang.cyh.etc;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class UploadImageProcess {
	
	
	public String uploadImageReName(String upPath, String orginalFileName, byte[] file) throws IOException {
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid.toString() + "_" + orginalFileName;
		String savePath = upPath + calculateSavePath(upPath); // 파일이 저장될 경로 계산
		File file1 = new File(savePath);
		 File[] flist =file1.listFiles();
		if(flist.length > 0 ) {
			DeleteFileProcess dfp = new DeleteFileProcess();
			dfp.deleteFile(savePath);
		}
		File target = new File(savePath + File.separator, saveFileName);
		FileCopyUtils.copy(file, target);
		System.out.println(savePath);
		
		String imagePath = ((savePath +File.separator +saveFileName).substring(upPath.length())).replace(File.separator, "/");
		
		return imagePath;
	}
	
	
	public String calculateSavePath(String upPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator +cal.get(Calendar.YEAR) + ""; // \2022
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); // \2022\03
		String datePath = monthPath + File.separator  + new DecimalFormat("00").format(cal.get(Calendar.DATE)); // \2022\03\15
		
		System.out.println(datePath);
		
		makeDir(upPath, yearPath, monthPath, datePath);
		
		
		return datePath;
		
		
	}
	
	
	private void makeDir(String upPath, String...paths) {
		// String... : 가변인자 배열로 받은 것이라고 컴파일러에게 알려줌. yearPath, monthPath, datePath의 값을 배열로 넘겨줌
		System.out.println(Arrays.toString(paths));
		
		if(new File(upPath + paths[paths.length-1]).exists()) {
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
