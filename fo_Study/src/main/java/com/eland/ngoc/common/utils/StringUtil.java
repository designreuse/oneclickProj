package com.eland.ngoc.common.utils;

import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;

public class StringUtil {
	
	public static boolean isEmpty(String str) {
		return ((str == null) || (str.length() == 0));
	}

	public static boolean isNotEmpty(String str) {
		return ((str != null) && (str.length() > 0));
	}

	public static String nvl(Object obj) {
		return nvl(obj, "");
	}

	public static String nvl(Object obj, String ifNull) {
		return ((obj != null) ? obj.toString() : ifNull);
	}

	public static String getMapValue(Map<String, Object> map, String key) {
		String value = "";
		if (map != null) {
			value = (String) map.get(key);
		}
		return nvl(value);
	}

	public static boolean isNumeric(String s) {
		return NumberUtils.isNumber(s);
	}

	public static byte[] getByteArrayFromHex(String hex) {
		if ((hex == null) || (hex.length() == 0)) {
			return null;
		}
		byte[] ba = new byte[hex.length() / 2];
		for (int i = 0; i < ba.length; ++i) {
			ba[i] = (byte) Integer
					.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		}
		return ba;
	}

}
