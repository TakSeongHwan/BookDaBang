<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${contextPath}/resources/js/jQueryImageCaching.js"></script>

  <meta charset="utf-8">
  <title>네이버 로그인</title>
  
</head>
<body>
 <input type='file' id="uploadBannerImage"/>
 <img id="bannerImg" alt="" src="">
 <img src="" id="tableBanner" />
 
 </body>
   <script>
   
   let bannerImg = "";
   window.onload = function() {
	 
	   $(document).on("change","#uploadBannerImage", function(e){
		 
		  setImageFromFile(this, '#bannerImg');
		  
		 
	   });
	   
	   
	   
	
   }
   function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(expression).attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
   
   function getDataUrl(img) {
	   // Create canvas
	   const canvas = document.createElement('canvas');
	   const ctx = canvas.getContext('2d');
	   // Set width and height
	   canvas.width = img.width;
	   canvas.height = img.height;
	   // Draw the image
	   ctx.drawImage(img, 0, 0);
	   
	   var base64 = canvas.toDataURL('image/*');
	   strImage = base64.replace(/^data:image\/[a-z]+;base64,/, "");
	   }
   
   
   
   
   
   
  </script>
</html>