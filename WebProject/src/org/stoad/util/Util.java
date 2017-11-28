package org.stoad.util;
//여러가지 복잡한 기능들을 편리하게 바로 쓸 수 있게 구현한 클래스
public class Util {
	public static boolean isEmpty(String str){
		return str==null||"".equals(str.trim());
	}
}
