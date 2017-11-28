package org.stoad.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.stoad.vo.UserVo;
//야구게임으로 세션이 있는지 확인한 후 보내주는 액션
public class BaseAction implements IAction{
	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		RequestDispatcher rd=null;
		if((UserVo)session.getAttribute("user")==null)
			rd=request.getRequestDispatcher("/jsp/login.jsp");
		else
			rd=request.getRequestDispatcher("/jsp/base.jsp");
		rd.forward(request, response);
	}
}
