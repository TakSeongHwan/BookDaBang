package com.bookdabang.tsh.etc;

import java.util.ArrayList;
import java.util.List;

public class StringToArray {

	public static List<Integer> squareBracketInt(String str){
		List<Integer> result = new ArrayList<Integer>();
		str = str.replace("[", "").replace("]", "");
		String[] strArray =  str.split(",");
		for(String s : strArray) {
			result.add(Integer.parseInt(s.trim()));
		}
		return result;
	}
}
