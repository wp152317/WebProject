package org.stoad.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//Action클래스 들을 다형성으롤 묶어서 업 캐스팅 하기 위한 인터페이스
public interface IAction {
	void excute(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException;
}
