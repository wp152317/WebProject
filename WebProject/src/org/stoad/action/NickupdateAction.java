package org.stoad.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.stoad.service.UserService;
import org.stoad.vo.UserVo;
//유저의 닉네임을 업데이트 하는 액션
public class NickupdateAction implements IAction{
	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		try {
			UserVo uv=(UserVo)session.getAttribute("user");
			uv.setNickname(request.getParameter("nickname"));
			UserService.changeNick(uv);
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		} finally{
			RequestDispatcher rd=request.getRequestDispatcher("/jsp/index.jsp");
			rd.forward(request, response);
		}
	}
}
