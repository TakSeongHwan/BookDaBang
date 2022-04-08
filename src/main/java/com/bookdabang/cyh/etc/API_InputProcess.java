package com.bookdabang.cyh.etc;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;
import java.net.URLEncoder;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.parsers.SAXParser;
import org.xml.sax.helpers.ParserAdapter;

import com.bookdabang.cyh.domain.ProdInfo;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;


class AladdinOpenAPIHandler extends DefaultHandler {
	public List<ProdInfo> Items;
	private ProdInfo currentItem;
	private boolean inItemElement = false;
	private String tempValue;

	public AladdinOpenAPIHandler( ){
		Items = new ArrayList<ProdInfo>();
	}

	public void startElement(String namespace, String localName, String qName, Attributes atts) {
		if (localName.equals("item")) {
			currentItem = new ProdInfo();
			inItemElement = true;
		} else if (localName.equals("author")) {
			tempValue = "";
		} else if (localName.equals("publisher")) {
			tempValue = "";
		} else if (localName.equals("pubDate")) {
			tempValue = "";
		} else if (localName.equals("description")) {
			tempValue = "";
		}else if (localName.equals("title")) {
			tempValue = "";
		}
	}
	
	public void characters(char[] ch, int start, int length) throws SAXException{
		tempValue = tempValue + new String(ch,start,length);
	}

	public void endElement(String namespaceURI, String localName,String qName) {
		if(inItemElement){
			if (localName.equals("item")) {
				Items.add(currentItem);
				currentItem = null;
				inItemElement = false;
			} else if (localName.equals("author")) {
				currentItem.author = tempValue;
			} else if (localName.equals("publisher")) {
				currentItem.publisher = tempValue;
			}else if (localName.equals("pubDate")) {
				currentItem.pubDate = tempValue;
			}else if (localName.equals("description")) {
				currentItem.description = tempValue;
			}else if (localName.equals("title")) {
				currentItem.title = tempValue;
			}
		}
	}

	public void parseXml(String xmlUrl) throws Exception {
            SAXParserFactory spf = SAXParserFactory.newInstance();
            SAXParser sp = spf.newSAXParser();
            ParserAdapter pa = new ParserAdapter(sp.getParser());
            pa.setContentHandler(this);
			pa.parse(xmlUrl);
	}
}

public class API_InputProcess {
	private static final String BASE_URL = "http://www.aladdin.co.kr/ttb/api/ItemSearch.aspx?";

	public static String GetUrl(String searchWord) throws Exception {
		Map<String,String> hm = new HashMap<String,String>();
		hm.put("ttbkey", "<TTBKey Here>");
		hm.put("Query", URLEncoder.encode(searchWord, "UTF-8"));
		hm.put("QueryType", "Title");
		hm.put("MaxResults", "10");
		hm.put("start", "1");
		hm.put("SearchTarget", "Book");
		hm.put("output", "xml");

		StringBuffer sb = new StringBuffer();
		Iterator<String> iter = hm.keySet().iterator();
		while (iter.hasNext()) {
			String key = iter.next();
			String val  = hm.get(key);
			sb.append(key).append("=").append(val).append("&");
		}

		return BASE_URL + sb.toString();
	}

	public ProdInfo apiInput(String isbn) throws Exception {
		ProdInfo prodInfo = null;
		String url = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbkrke98ss1728001&itemIdType=ISBN&ItemId="+isbn+"&output=xml&Version=20131101&OptResult=ebookList,usedList,reviewList'";
		AladdinOpenAPIHandler api = new AladdinOpenAPIHandler();
		api.parseXml(url);
		for(ProdInfo item : api.Items){
			
			prodInfo = item;
		}
		return prodInfo;
	}
}