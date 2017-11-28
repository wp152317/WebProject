package org.stoad.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.stoad.service.UserService;
import org.stoad.vo.UserVo;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
//기록 갱신을 해야할 때 사용되는 액션
public class ChangeAction implements IAction{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		JsonObject object = new JsonObject();
		try{
			String id=request.getParameter("id");
			String game=request.getParameter("game");
			String strType=request.getParameter("type");
			String strRecord=request.getParameter("record");
			if(strType==null||strRecord==null)throw new Exception("알 수 없는 방식의 호출입니다.");
			int type=Integer.parseInt(strType);
			int record=Integer.parseInt(strRecord);
			UserVo uv=new UserVo();
			uv.setId(id);
			UserService.changeRecord(uv, game, type, record);
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
