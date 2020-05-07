package com.dev.op.core.util;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.StringUtils;

public class StringUtil {

	private StringUtil() {
		
	}
	
	public static boolean hasText(String str) {
		return StringUtils.hasText(str);
	}
	
	@SuppressWarnings("rawtypes")
	public static String concat(Collection list, String sep) {
		return concat(list, sep, null);
	}
	
	@SuppressWarnings("rawtypes")
	public static String concat(Collection list, String sep, String enclosing) {
		
		StringBuilder buf = new StringBuilder();
		
		for(Object str : list) {
			
			if(buf.length() > 0) {
				buf.append(sep);
			}
			
			if(enclosing != null) {
				buf.append(enclosing);
			}
			
			buf.append(str);
			
			if(enclosing != null) {
				buf.append(enclosing);
			}			
		}
		return buf.toString();
	}
	
	public static String nvl(String s1, String s2) {
		return hasText(s1) ? s1 : s2;
	}
	
	public static String trunc(String str, int maxLength) {
		return str == null || str.length() < maxLength ? str : str.substring(0, maxLength);
	}
	
	public static boolean isEmpty(String str) {
		return !hasText(str);
	}
	
	public CharSequence removeStartEndLineFeed(CharSequence str) {
		
		StringBuffer buf = str instanceof StringBuffer ? (StringBuffer) str : new StringBuffer(str);
		
		if(buf.charAt(0) == 13 || buf.charAt(0) == 10) {
			buf.deleteCharAt(0);
		}
		
		if(buf.charAt(buf.length() -1) == 13 || buf.charAt(buf.length() -1) == 10) {
			buf.deleteCharAt(buf.length() -1);
		}
		return buf;
	}
	
	public static Integer parseIntNull(String str) {
		
		try {
			return Integer.valueOf(str);
		}
		catch(NumberFormatException e) {
			return null;
		}
	}
	
	public static Long parseLongNull(String str) {
		
		if(str == null) {
			return  null;
		}
		
		try {
			
			return Long.valueOf(str);
		}
		catch(NumberFormatException e) {
			return null;
		}
	}
	
	public static BigDecimal parseBigDecimalNull(String str) {
		
		if(str == null) {
			return null;
		}
		
		try {
			
			return new BigDecimal(str);
		}
		catch(NumberFormatException e) {
			return null;
		}
	}
	
	public static String integerToString(Integer value) {
		
		if(value == 0) {
			return null;
		}
		
		String numberAsString = Integer.toString(value);
		return numberAsString;
	}
	
	public static String bigDecimalToString(BigDecimal value) {
		
		BigDecimal bigDecimal = new BigDecimal(value.intValue());
		String toStringBigDecimal = bigDecimal.toString();
		return toStringBigDecimal;
	}
	
	public static Double parseDoubleNull(String str) {
		
		if(str == null) {
			return null;
		}
		try {
			
			return Double.valueOf(str);
		}
		catch(NumberFormatException e) {
			return null;
		}
	}
	
	public static boolean validateTextWithPattern(String texto, String patternStr) {
		
		boolean isCorrect = false;
		Pattern pattern = null;
		Matcher matcher = null;
		
		try {
			
			if(texto != null && patternStr != null) {
				pattern = Pattern.compile(patternStr);
				matcher = pattern.matcher(texto);
				
				if(matcher.find()) {
					isCorrect = true;
				}
			}
			return isCorrect;
		}
		catch(Exception e) {
			System.out.println("Error in validateTextWithPattern : " + e);
		}
		return isCorrect;
	}
	
	public static String trim(String str) {
		return str == null ? null : str.trim();
	}
	
	public static List<String> upperCase(List<String> list) {
		
		for(int i = 0; i < list.size(); i++) {
			list.set(i, list.get(i).toUpperCase());
		}
		return list;
	}
	
	public static String toJavaName(String dbColName) {
		
		String[] parts = dbColName.toLowerCase().trim().split("_");
		for(int i = 1; i < parts.length; i++) {
			String part = parts[i];
			if(part.length() > 0) {
				parts[i] = part.substring(0, 1).toUpperCase() + (part.length() > 1 ? part.substring(1) : "");
			}
		}
		return concat(Arrays.asList(parts), "");
	}
	
	public static String last(String str, int size) {
		
		int length = str.length();
		
		if(length <= size) {
			return str;
		}
		else {
			return str.substring(length - size);
		}
	}
	
	public static boolean eq(String str1, String str2) {
		
		if(str1 != null && str2 != null) {
			return str1.equals(str2);
		}
		else {
			return str1 == null && str2 == null;
		}
	}
	
	public static String trimEnd(String value) {
		return value.replaceFirst("\\s+$", "");
	}
	
	public static String trimStart(String value) {
		
		if(value == null) {
			return "";
		}
		return value.replaceFirst("^\\s+", "");
	}
	
	public static String autoCompleteZeroLeft(String value) {
		
		String result = "";
		
		if(value != null && !value.equals("")) {
			if(value.length() == 1) {
				result = "0" + value;
			}
			else {
				result = value;
			}
		}
		return result;
	}
	
	public static String toCamelCase(String value) {
		
		String result = "";
		
		if(value == null || value.equals("")) {
			return result;
		}
		
		value = value.trim().toLowerCase();
		String[] values = value.split(" ");
		
		for(String val : values) {
			
			String firstLetter = val.substring(0, 1);
			firstLetter = firstLetter.toUpperCase();
			String sub = firstLetter.concat(val.substring(1, val.length()));
			result = result + sub + " ";
		}
		return result;
	}

	public static String toUpperCase(String str) {
		
		String result = "";
		result = str.toUpperCase();
		return result;
	}
	
	public static void objectToUpperCase(Object input) {
		
		try {
			
			for(Field field : input.getClass().getDeclaredFields()) {
				if(field.getType().equals(String.class)) {
					if(!field.isAccessible())
						field.setAccessible(true);
					if(field.get(input) != null && !((String) field.get(input)).trim().equals(Constantes.EMPTY)) {
						field.set(input, ((String) field.get(input)).toUpperCase());
					}
				}
			}
		}
		catch(IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}
}
