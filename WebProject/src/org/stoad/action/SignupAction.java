package org.stoad.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.stoad.service.UserService;
import org.stoad.util.Util;
import org.stoad.vo.UserVo;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
//회원가입을 요청할때 호출되는 액션
public class SignupAction implements IAction{
	public void validate(UserVo vo) throws Exception{
		if(vo==null)throw new NullPointerException("UserVo is Null");
		if(Util.isEmpty(vo.getId()))throw new Exception("must enter id");
		if(Util.isEmpty(vo.getPwd()))throw new Exception("must enter pwd");
		if(Util.isEmpty(vo.getName()))throw new Exception("must enter name");
	}
	
	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		JsonObject object = new JsonObject();
		try{
			String id=request.getParameter("id");
			String pwd=request.getParameter("pwd");
			String name=request.getParameter("name");
			String nickname=request.getParameter("nickname");
			System.out.println("ID : "+id);
			System.out.println("Password : "+pwd);
			System.out.println("Name : " + name);
			System.out.println("Nickname : "+nickname);
			UserVo uv = Util.isEmpty(nickname) ? new UserVo(id,pwd,name)
					: new UserVo(id,pwd,name,nickname);
			validate(uv);
			UserService.signUp(uv);
	        object.addProperty("suc", true);
		}
		catch(Exception e){
			object.addProperty("suc", false);
		}finally{
			String json = gson.toJson(object);
			PrintWriter out = response.getWriter();
			out.write(json);
		}
	}
}
