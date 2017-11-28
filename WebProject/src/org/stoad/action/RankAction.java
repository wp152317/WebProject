package org.stoad.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.stoad.service.UserService;
import org.stoad.vo.UserVo;
//세션 체크 및 유저 전체/개인 랭킹을 불러오는 액션
public class RankAction implements IAction{
	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd=null;
		try {
		HttpSession session=request.getSession();
		if((UserVo)session.getAttribute("user")==null)
			throw new Exception("로그인 해야 이용 가능합니다");
		else{
			request.setAttribute("rank", UserService.getRanking());
			request.setAttribute("recd",
					UserService.getRecords((UserVo)session.getAttribute("user")));
			rd=request.getRequestDispatcher("/jsp/rank.jsp");
		}
		} catch (Exception e) {
			e.printStackTrace();
			rd=request.getRequestDispatcher("/jsp/login.jsp");
		}
		finally{
			rd.forward(request, response);
		}
	}
}
