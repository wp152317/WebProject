package org.stoad.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.stoad.service.UserService;
import org.stoad.vo.UserVo;


//로그인 요청을 처리해주는 액션
public class LoginAction implements IAction{

	private void validate(String id,String pwd) throws Exception{
		if(id==null||"".equals(id.trim())){
			throw new Exception("id를 입력하시오");
		}
		if(pwd==null||"".equals(pwd.trim())){
			throw new Exception("pwd를 입력하시오");
		}
	}
	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			request.setCharacterEncoding("utf-8");
			String id=request.getParameter("id");
			String pwd=request.getParameter("pwd");
			System.out.println(id +"\n"+ pwd);
			validate(id,pwd);
			UserVo uv= new UserVo();
			uv.setId(id);
			uv.setPwd(pwd);
			uv=UserService.login(uv);
			request.getSession().setAttribute("user", uv);
			RequestDispatcher rd=request.getRequestDispatcher("/jsp/index.jsp");
			rd.forward(request, response);
		}catch(Exception e){
			//request.setAttribute("msg", "error");
			request.setAttribute("error", e.getMessage());
			RequestDispatcher rd=request.getRequestDispatcher("/jsp/login.jsp");
			rd.forward(request, response);
		}
	}
}
