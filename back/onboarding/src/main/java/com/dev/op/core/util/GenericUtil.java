package com.dev.op.core.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Collection;
import java.util.Map;

public class GenericUtil {

	private GenericUtil() {
		
	}
	
	/**
	 * 
	 * checks if the object is not empty
	 * 
	 * @param object
	 * 
	 * @return true or false
	 * 
	 */
	public static boolean isNotEmpty(Object object) {
		
		return !isObjectEmpty(object);
	}
	
	/**
	 *
	 * checks if the collection is empty
	 * 
	 * @param collection
	 * 
	 * @return true or false
	 * 
	 */
	public static <E> boolean isEmpty(Collection<E> collection) {
		
		return (collection == null) || (collection.isEmpty());
	}
	
	/**
	 * 
	 *checks if the map is empty 
	 * 
	 * @param map
	 * 
	 * @return true or false
	 * 
	 */
	public static <K, E> boolean isEmpty(Map<K, E> map) {
		
		return (map == null) || (map.isEmpty());
	}
	
	/**
	 * 
	 *checks if the character is empty 
	 * 
	 * @param character
	 * 
	 * @return true or false
	 * 
	 */
	public static boolean isEmpty(CharSequence character) {
		return (character == null) || (character.length() == 0);
	}
	
	public static String emptyIfStringNull(String character) {
		
		if(isEmpty(character)) {
			return Constantes.EMPTY;
		}
		return character;
	}
	
	/**
	 * 
	 *checks if the object is empty
	 *
	 * @param object value
	 * 
	 * @return true or false
	 * 
	 */
	public static boolean isObjectEmpty(Object value) {
		
		if(value == null) {
			return true;
		}
		else if(value instanceof String) {
			return isEmpty((String) value);
		}
		else if(value instanceof CharSequence) {
			return isEmpty((CharSequence)value);
		}
		else if(value instanceof Collection || value instanceof Map) {
			return isCollectionEmpty(value);
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public static boolean isCollectionEmpty(Object value) {
		
		if(value instanceof Collection) {
			return isEmpty((Collection<? extends Object>) value);
		}
		else {
			return isEmpty((Map<? extends Object, ? extends Object>) value);
		}
	}
	
	/**
	 * 
	 *checks if the object is null 
	 * 
	 * @param object
	 * 
	 * @return true or false
	 */
	public static boolean isNull(Object object) {
		
		if(object != null) {
			return false;
		}
		return true;
	}
	
	/**
	 * 
	 *checks if the object is not null 
	 * 
	 * @param object
	 * 
	 * @return true or false
	 * 
	 */
	public static boolean isNotNull(Object object) {
		
		if(object != null) {
			return true;
		}
		return false;
	}
	
	public static BigDecimal getSubtotal(BigDecimal total, Integer valorImpuesto) {
		
		if(valorImpuesto == null) {
			return null;
		}
		
		BigDecimal subTotal = new BigDecimal("0.00");
		
		try {
			
			BigDecimal valorImpuestoDecimal = (new BigDecimal(valorImpuesto).divide(new BigDecimal(100))).add(new BigDecimal(1));
			subTotal = total.divide(valorImpuestoDecimal, 2, RoundingMode.HALF_UP);
			return subTotal;
		}
		catch(NumberFormatException e) {
			return null;
		}
	}
	
	public static BigDecimal getIgv(BigDecimal total, Integer valorImpuesto) {
		
		if(total == null) {
			return null;
		}
		
		BigDecimal igv = new BigDecimal("0.00");
		
		try {
			
			igv = total.subtract(getSubtotal(total, valorImpuesto));
			return igv;
		}
		catch(NumberFormatException e) {
			return null;
		}
	}
	
	public static void main(String[] args) {
		System.out.println(getIgv(new BigDecimal("50.00"), 18));
	}
	
	
}
