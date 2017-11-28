package org.stoad.service;

import java.sql.Connection;
import java.util.ArrayList;

import org.stoad.dao.UserDao;
import org.stoad.vo.RecordVo;
import org.stoad.vo.UserVo;
//User에게 필요한 서비스를 제공하는 클래스
public class UserService extends AbstractService{
	public static ArrayList<ArrayList<ArrayList<RecordVo>>> getRanking() throws Exception{
		Connection conn=null;
		try{
			conn=getConnection();
			UserDao dao=new UserDao(conn);
			return dao.searchRanking();
			
		}finally{
			if(conn!=null)conn.close();
		}
	}
	public static ArrayList<ArrayList<ArrayList<RecordVo>>> getRecords(UserVo user) throws Exception{
		Connection conn=null;
		try{
			conn=getConnection();
			UserDao dao=new UserDao(conn);
			return dao.searchRecords(user);
			
		}finally{
			if(conn!=null)conn.close();
		}
	}
	public static void changeNick(UserVo user)throws Exception{
		Connection conn=null;
		try{
			conn=getConnection();
			UserDao dao=new UserDao(conn);
			dao.updateUserNickname(user);
		}finally{
			if(conn!=null)conn.close();
		}
	}
	public static void changeRecord(UserVo user,String game,int type,int record)throws Exception{
		Connection conn=null;
		try{
			conn=getConnection();
			UserDao dao=new UserDao(conn);
			dao.setUserRecord(user, game, type, record);
			int result=dao.getRecord(user, game, type);
			if(result>0&&result<record)record=result;
			dao.saveRecord(user, game, type, record);
		}finally{
			if(conn!=null)conn.close();
		}
	}
	public static UserVo login(UserVo user) throws Exception{
		Connection conn=null;
		try{
			conn=getConnection();
			UserDao dao=new UserDao(conn);
			UserVo result = dao.searchUser(user);
			System.out.println(result);
			if(result==null){
				throw new Exception("Invalid User Name or Password");
			}
			return result;
		}finally{
			if(conn!=null)conn.close();
		}
	}
	public static void signUp(UserVo uv) throws Exception{
		Connection conn=null;
		try{
			conn=getConnection();
			UserDao dao = new UserDao(conn);
			if(!dao.checkUserById(uv)){
				throw new Exception("이미 사용중인 ID 입니다.");
			}
			dao.insertUser(uv);
		}finally{
			if(conn!=null)conn.close();
		}
	}
}
