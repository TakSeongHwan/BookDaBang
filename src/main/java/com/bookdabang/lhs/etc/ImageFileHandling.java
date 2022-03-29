package com.bookdabang.lhs.etc;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class ImageFileHandling {

	public String fileRenaming(String orgFileName) throws IOException {
		
		UUID uuid = UUID.randomUUID();
		String newFileName = uuid.toString() + "_" + orgFileName;
		
		return newFileName;
		
		
	}	
	public void fileUploading(String newFileName, String upPath, byte[] file) throws IOException {
		File target = new File(upPath + File.separator, newFileName);
		FileCopyUtils.copy(file,target);//파일 저장
	}


}
