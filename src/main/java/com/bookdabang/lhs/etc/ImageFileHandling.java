package com.bookdabang.lhs.etc;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;

public class ImageFileHandling {

	public void fileUploading(String orgFileName, String upPath, byte[] file) throws IOException {
		File target = new File(upPath + File.separator, orgFileName);
		FileCopyUtils.copy(file,target);
	}

	public boolean fileDelete(String upPath,String targetFile) {
		boolean result = false;
		
		System.out.println(upPath+targetFile);
		
		File delFile = new File(upPath+targetFile.replace("/", File.separator));
		System.out.println(upPath+targetFile.replace("/", File.separator));
		if(delFile.delete()) {
			result = true;
		}else {
			result = false;
		}
		
		
		
		return result;
		
	}
}
