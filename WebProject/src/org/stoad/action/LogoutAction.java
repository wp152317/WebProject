package org.stoad.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//로그아웃 요청을 처리해주는 액션
public class LogoutAction implements IAction{
	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session=request.getSession();
			session.invalidate();
			RequestDispatcher rd=request.getRequestDispatcher("/jsp/index.jsp");
			rd.forward(request, response);
	}
}
