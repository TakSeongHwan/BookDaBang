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
 <input type='file' id="uploadBannerImage" onchange="readURL(this);" />
 <img id="bannerImg" alt="" src="">
 <img src="" id="tableBanner" />
 
 </body>
   <script>
   window.onload = function() {
	   var dataImage = localStorage.getItem('imgData');
	   bannerImg = document.getElementById('tableBanner');
	   bannerImg.src = "data:image/png;base64,"+  dataImage;
	
   }
   
   
   function readURL(input)  {
       document.getElementById("bannerImg").style.display = "block";

       if (input.files && input.files[0]) {
           var reader = new FileReader();

           reader.onload = function (e) {
               document.getElementById('bannerImg').src =  e.target.result;
           }

           reader.readAsDataURL(input.files[0]);
           bannerImage = document.getElementById('bannerImg');
    	   imgData = getBase64Image(bannerImage);
    	   localStorage.setItem("imgData", imgData);
       }
   }
   
   function getBase64Image(img) {
	    var canvas = document.createElement("canvas");
	    canvas.width = img.width;
	    canvas.height = img.height;

	    var ctx = canvas.getContext("2d");
	    ctx.drawImage(img, 0, 0);

	    var dataURL = canvas.toDataURL("image/png");

	    return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
	}
   
  </script>
</html>