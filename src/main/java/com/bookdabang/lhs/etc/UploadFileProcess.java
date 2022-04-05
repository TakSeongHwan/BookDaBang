package com.bookdabang.lhs.etc;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.etc.MediaConfirm;

public class UploadFileProcess {
	
	private AttachFileVO uploadAttachFile = new AttachFileVO();

	public AttachFileVO uploadFileRename(String upPath, String originalFilename, byte[] file) throws IOException {
		UUID uuid = UUID.randomUUID();
		String saveFileName = uuid.toString() + "_" + originalFilename;
		String savePath = upPath + calculateSavePath(upPath);
		File target = new File(savePath + File.separator, saveFileName);
		FileCopyUtils.copy(file,target);
		
		this.uploadAttachFile.setOriginFile((savePath + File.separator+ saveFileName).substring(upPath.length()).replace(File.separator, "/"));
		
		String ext = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
		if(MediaConfirm.getMediaType(ext.toLowerCase()) != null) {
			
		
			makeThumbnail(upPath, savePath,saveFileName);
		}else {

			String fileName = savePath + File.separator + saveFileName;
			this.uploadAttachFile.setNotImageFile(fileName.substring(upPath.length()).replace(File.separator, "/"));
		
		}
		
		return this.uploadAttachFile;
		
	}
	
	private void makeThumbnail(String upPath, String savePath, String saveFileName) throws IOException {
		String originalFileName = savePath + File.separator + saveFileName;
		System.out.println("원본 파일 이름 : " + originalFileName);
		
		BufferedImage originFile = ImageIO.read(new File(originalFileName));
		int heightOfOtiginFile = originFile.getHeight();
		BufferedImage destFile  = null;
		if(heightOfOtiginFile > 100) {

			destFile = Scalr.resize(originFile, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		}else {
			
			destFile = originFile;
		}
	
		String thumbnailImageFileName = savePath + File.separator + "thumb_" + saveFileName;
	
		File newThumbnailFile = new File(thumbnailImageFileName);
		ImageIO.write(destFile,thumbnailImageFileName.substring(thumbnailImageFileName.lastIndexOf(".")+1), newThumbnailFile);
		
		this.uploadAttachFile.setThumbnailFile(thumbnailImageFileName.substring(upPath.length()).replace(File.separator, "/"));
		
	}

	
	public String calculateSavePath(String upPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR)+"";
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(upPath, yearPath, monthPath, datePath);		
	
		return datePath;
	}
	
	public void makeDir(String upPath, String... paths) {
		if(new File(upPath + paths[paths.length-1]).exists()) {
			return;
		}
		for(String path : paths) {
			File dirPath = new File(upPath + path);
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
	
	
	}
	