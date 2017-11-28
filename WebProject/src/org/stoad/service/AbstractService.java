package org.stoad.service;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
//커넥션을 갖고오는 것을 구현해둔 서비스 클래스들의 상위 추상클래스
public abstract class AbstractService {
	public static Connection getConnection() throws Exception{
		try{
			Context context = new InitialContext();
			DataSource dataSource = (DataSource)context.lookup("java:comp/env/jdbc/mysql");
			return dataSource.getConnection();
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("DB의 커넥션을 갖고 오는 도중 오류가 발생하였습니다.");
		}
	}
}
