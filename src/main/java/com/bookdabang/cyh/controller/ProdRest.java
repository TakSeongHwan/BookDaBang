package com.bookdabang.cyh.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.InsertProdDTO;
import com.bookdabang.cyh.domain.ProdInfo;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;
import com.bookdabang.cyh.domain.deleteProdDTO;
import com.bookdabang.cyh.etc.UploadImageProcess;
import com.bookdabang.cyh.service.ProductService;

@RestController
@RequestMapping(value = "/prodRest", method = RequestMethod.POST)
public class ProdRest {

	@Inject
	private ProductService service;

	@RequestMapping(value = "/all/{pageno}", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> listAll(Model model, @ModelAttribute SearchCriteria sc,
			@PathVariable("pageno") int pageno) {
		ResponseEntity<Map<String, Object>> result = null;

		Map<String, Object> map;
		try {
			map = service.conditionProdView(sc, pageno);
			System.out.println(sc.toString());
			result = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}

	@RequestMapping(value = "/selectView", method = RequestMethod.POST)
	public ResponseEntity<List<ProductVO>> selectListView(Model model, @RequestParam(value = "checkBoxs[]") List<String> checkProd) {
		ResponseEntity<List<ProductVO>> result = null;
		try {
			List<ProductVO> lst = service.selectProdView(checkProd);
			result = new ResponseEntity<List<ProductVO>>(lst, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;

	}
	
	

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public ResponseEntity<String> updateList(Model model, @RequestBody List<UpdateProdDTO> list) {

		System.out.println(list.toString());
		ResponseEntity<String> result = null;
		try {
			if (service.updateSelectProd(list)) {
				result = new ResponseEntity<String>("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;

	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<Integer> deleteList(Model model, @RequestBody List<deleteProdDTO> list, HttpServletRequest req) {
		System.out.println(list.toString());
		String upPath = req.getSession().getServletContext().getRealPath("resources/uploads");
		ResponseEntity<Integer> result = null;
		
		try {
			 int deleteCount = service.deleteSelectProd(list ,upPath);
			if(deleteCount > 0) {
				result = new ResponseEntity<Integer>(deleteCount, HttpStatus.OK);
			} else {
				result = new ResponseEntity<Integer>(deleteCount, HttpStatus.OK);
			}
			 
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;

	}

	@RequestMapping(value = "/d", method = RequestMethod.POST)
	public ResponseEntity<String> validationProdNo(Model model, @RequestBody String isbn) {

		System.out.println(isbn.split("=")[1]);
		String Isbn = isbn.split("=")[1];

		ResponseEntity<String> result = null;
		try {
			if (service.validationProdNo(Isbn)) {
				result = new ResponseEntity<String>("validate", HttpStatus.OK);

			} else {
				result = new ResponseEntity<String>("unValidate", HttpStatus.OK);
			}
		} catch (Exception e) {

			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}

	@RequestMapping(value = "/a", method = RequestMethod.POST)
	public ResponseEntity<ProdInfo> viewInfoByIsbn(Model model, @RequestBody String isbn) {

		System.out.println(isbn.split("=")[1]);
		String Isbn = isbn.split("=")[1];

		ResponseEntity<ProdInfo> result = null;
		try {
			ProdInfo prodInfo = service.viewInfoByIsbn(Isbn);
			result = new ResponseEntity<ProdInfo>(prodInfo, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return result;
	}

	@RequestMapping(value = "/b", method = RequestMethod.POST)
	public ResponseEntity<String> uploadImage(Model model, MultipartFile image, HttpServletRequest req) {

		System.out.println("업로드된 파일 이름 : " + image.getOriginalFilename());

		String upPath = req.getSession().getServletContext().getRealPath("resources/uploads");
		System.out.println("파일이 업로드 되는 실제 물리적 경로 : " + upPath);
		ResponseEntity<String> result = null;
		UploadImageProcess uip = new UploadImageProcess();

		try {
			String imagePath = uip.uploadImageReName(upPath, image.getOriginalFilename(), image.getBytes());
			System.out.println("이미지 패스? :" + imagePath);
			result = new ResponseEntity<String>(imagePath, HttpStatus.OK);
		} catch (Exception e) {
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();

		}

		return result;
	}

	@RequestMapping(value = "/c", method = RequestMethod.DELETE)
	public ResponseEntity deleteImage(Model model, @RequestBody String imagePath, HttpServletRequest req) {
		ResponseEntity<String> result = null;

		if (imagePath != null) {
			imagePath = imagePath.replaceAll("%2F", "/");

			String upPath = req.getSession().getServletContext().getRealPath("resources/uploads");
			try {
				service.deleteImage(upPath, imagePath);
				result = new ResponseEntity(HttpStatus.OK);
			} catch (Exception e) {
				result = new ResponseEntity(HttpStatus.BAD_REQUEST);
				e.printStackTrace();
			}
		}

		return result;
	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public ResponseEntity<String> insertProd(Model model, @ModelAttribute InsertProdDTO product) {

		System.out.println(product.toString());
		ResponseEntity<String> result = null;

		try {
			if (service.insertProd(product)) {
				result = new ResponseEntity("success", HttpStatus.OK);
			} else {
				result = new ResponseEntity("fail", HttpStatus.OK);
			}
		} catch (Exception e) {
			result = new ResponseEntity(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}

		return result;
	}
	
	
}
