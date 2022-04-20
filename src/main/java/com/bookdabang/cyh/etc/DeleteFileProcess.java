package com.bookdabang.cyh.etc;

import java.io.File;

public class DeleteFileProcess {
	
	
	public void deleteFile (String filepath){      

		  File path = new File( filepath );

		        File[] fileList = path.listFiles();

		        for(int i=0; i<fileList .length; i++){

		            System.out.println(i + "번째파일 : ");

		            if ( fileList[i].delete() ){

		                System.out.println("삭제성공");

		            }else{

		                System.out.println("삭제실패");

		            }

		        }

		    }


		

}
