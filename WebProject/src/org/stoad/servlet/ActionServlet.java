package org.stoad.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.stoad.action.BaseAction;
import org.stoad.action.ChangeAction;
import org.stoad.action.IAction;
import org.stoad.action.LoginAction;
import org.stoad.action.LogoutAction;
import org.stoad.action.MineAction;
import org.stoad.action.NickupdateAction;
import org.stoad.action.RankAction;
import org.stoad.action.SignupAction;


/**
 * Servlet implementation class ActionServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "*.do" })
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Map<String, IAction> actions = new HashMap<String,IAction>();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public void init() throws ServletException{
    	//*.do에서 *에 해당하는 것들을 각 액션 클래스들과 map을 이용하여 연결한다.
    	actions.put("login", new LoginAction());
    	actions.put("logout", new LogoutAction());
    	actions.put("signup", new SignupAction());
    	actions.put("base",  new BaseAction());
    	actions.put("mine",  new MineAction());
    	actions.put("rank",  new RankAction());
    	actions.put("change", new ChangeAction());
    	actions.put("upnick", new NickupdateAction());
    }
    public ActionServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request,response);
	}
	//get, post 방식 모두 process로 처리함
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			init();
			request.setCharacterEncoding("utf-8");
			String URI = request.getRequestURI();
			System.out.println(URI);
			String actionName=URI.substring(URI.lastIndexOf("/")+1,URI.lastIndexOf("."));
			System.out.println(actionName);
			IAction action=actions.get(actionName);
			if(action==null){
				throw new Exception(actionName + "에 해당하는 Action 클래스가 없습니다.");
			}
			action.excute(request, response);
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("error", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("jsp/error.jsp");
			rd.forward(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request,response);
	}
}
