package org.stoad.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.stoad.vo.RecordVo;
import org.stoad.vo.UserVo;


//유저 요청에 의한 DB 커넥션을 처리해주는 DAO
public class UserDao {
	private Connection conn=null;
	public UserDao(Connection conn){
		this.conn=conn;
	}
	public void updateUserNickname(UserVo vo) throws Exception{
		PreparedStatement pstmt=null;
		String sql="UPDATE GAMEUSER SET NICKNAME = ? WHERE ID = ?";
		try{
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getNickname());
			pstmt.setString(2, vo.getId());
			System.out.println(pstmt);
			int cnt=pstmt.executeUpdate();
			if(cnt==0)throw new Exception("닉네임의 갱신에 실패하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("닉네임의 갱신시 오류가 발생하였습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public void setUserRecord(UserVo vo,String game,int type,int record) throws Exception{
		PreparedStatement pstmt=null;
		String sql="INSERT INTO GAMERECORD (ID,TYPE,SCORE) VALUES(?,?,?)";
		try{
			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, vo.getId());
			pstmt.setString(2, game+type);
			pstmt.setInt(3, record);
			System.out.println(vo);
			int cnt=pstmt.executeUpdate();
			if(cnt==0)throw new Exception("개인 기록 등록에 실패하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("개인 기록 등록 시 오류가 발생했습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public int getRecord(UserVo vo,String game,int type) throws Exception{
		PreparedStatement pstmt=null;
		String sql="SELECT "+(game+type)+" FROM GAMEUSER WHERE ID = ?";
		try{
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getId());
			System.out.println(pstmt);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception(game+type+"종목의 게임에 최고기록을 불러오는데 오류가 발생하였습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public void saveRecord(UserVo vo,String game,int type,int record) throws Exception{
		PreparedStatement pstmt=null;
		String sql="UPDATE GAMEUSER SET "+(game+type)+" = ? WHERE ID = ?";
		try{
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, record);
			pstmt.setString(2, vo.getId());
			System.out.println(pstmt);
			int cnt=pstmt.executeUpdate();
			if(cnt==0)throw new Exception(game+type+"종목의 게임에 최고 기록 갱신에 실패하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception(game+type+"종목의 게임에 최고 기록 갱신시 오류가 발생하였습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public void insertUser(UserVo vo)throws Exception{
		PreparedStatement pstmt=null;
		String sql="INSERT INTO GAMEUSER (ID,PWD,NAME,NICKNAME) VALUES(?,?,?,?)";
		try{
			pstmt=conn.prepareStatement(sql);

			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getNickname());
			System.out.println(vo);
			int cnt=pstmt.executeUpdate();
			if(cnt==0)throw new Exception("사용자 등록에 실패하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("시용자 등록 시 오류가 발생했습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public boolean checkUserById(UserVo vo)throws Exception{
		PreparedStatement pstmt=null;
		String sql = "SELECT * FROM GAMEUSER WHERE ID=?";
		ResultSet rs=null;
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			rs=pstmt.executeQuery();
			if(rs.next())return false;
			return true;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("DB에 사용자 조회에 오류가 발생했습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public UserVo searchUser(UserVo vo)throws Exception{
		PreparedStatement pstmt=null;
		String sql = "SELECT * FROM GAMEUSER WHERE ID=? AND PWD=?";
		ResultSet rs=null;
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPwd());
			rs=pstmt.executeQuery();
			UserVo result=null;
			if(rs.next()){
				result = new UserVo();
				result.setId(rs.getString("ID"));
				result.setPwd(rs.getString("PWD"));
				result.setName(rs.getString("NAME"));
				result.setNickname(rs.getString("NICKNAME"));
			}
			return result;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("로그인을 하는 도중에 오류가 발생했습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public ArrayList<ArrayList<ArrayList<RecordVo>>> searchRanking() throws Exception{
		PreparedStatement pstmt=null;
		String[][] sql={new String[]{
				"SELECT ID,NICKNAME,BASE3 FROM GAMEUSER WHERE BASE3>0 ORDER BY BASE3 ASC LIMIT 5",
				"SELECT ID,NICKNAME,BASE4 FROM GAMEUSER WHERE BASE4>0 ORDER BY BASE4 ASC LIMIT 5",
				"SELECT ID,NICKNAME,BASE5 FROM GAMEUSER WHERE BASE5>0 ORDER BY BASE5 ASC LIMIT 5",
		}
		,new String[]{
				"SELECT ID,NICKNAME,MINE1 FROM GAMEUSER WHERE MINE1>0 ORDER BY MINE1 ASC LIMIT 5",
				"SELECT ID,NICKNAME,MINE2 FROM GAMEUSER WHERE MINE2>0 ORDER BY MINE2 ASC LIMIT 5",
				"SELECT ID,NICKNAME,MINE3 FROM GAMEUSER WHERE MINE3>0 ORDER BY MINE3 ASC LIMIT 5",
		}};
		final int[][] dftnum={
				{999,9999,99999},
				{3599,3599,3599}
		};
		ResultSet rs=null;
		ArrayList<ArrayList<ArrayList<RecordVo>>> list=
				new ArrayList<ArrayList<ArrayList<RecordVo>>>();
		try{
			for(int i=0;i<2;i++){
				list.add(new ArrayList<ArrayList<RecordVo>>());
				for(int j=0;j<3;j++){
						list.get(i).add(new ArrayList<RecordVo>());
						pstmt=conn.prepareStatement(sql[i][j]);
						rs=pstmt.executeQuery();
						
						while(rs.next()){
							RecordVo rv=new RecordVo();
							rv.setId(rs.getString(1).split("@")[0]);
							rv.setNickname(rs.getString(2));
							rv.setScore(rs.getInt(3));
							list.get(i).get(j).add(rv);
							System.out.println(rv.getId()+" "+rv.getNickname()+" "+rv.getScore());
						}
						while(list.get(i).get(j).size()<5){
							RecordVo rv=new RecordVo();
							rv.setId("NO0");
							rv.setNickname("NO USER");
							rv.setScore(dftnum[i][j]);
							list.get(i).get(j).add(rv);
							System.out.println(rv.getId()+" "+rv.getNickname()+" "+rv.getScore());
						}
						System.out.println();
				}
				System.out.println();
			}
			return list;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("전체 랭킹 조회 시 오류가 발생하였습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
	public ArrayList<ArrayList<ArrayList<RecordVo>>> searchRecords(UserVo uv) throws Exception{
		PreparedStatement pstmt=null;
		String sql=
				"SELECT ID,SCORE FROM GAMERECORD WHERE ID=? AND TYPE=? ORDER BY SCORE ASC LIMIT 5";
		ResultSet rs=null;
		ArrayList<ArrayList<ArrayList<RecordVo>>> list=
				new ArrayList<ArrayList<ArrayList<RecordVo>>>();
		String[][] types={
				{"BASE3","BASE4","BASE5"},
				{"MINE1","MINE2","MINE3"}
		};
		final int[][] dftnum={
				{999,9999,99999},
				{3599,3599,3599}
		};
		try{
			for(int i=0;i<2;i++){
				list.add(new ArrayList<ArrayList<RecordVo>>());
				for(int j=0;j<3;j++){
						list.get(i).add(new ArrayList<RecordVo>());
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, uv.getId());
						pstmt.setString(2, types[i][j]);
						System.out.println(pstmt);
						rs=pstmt.executeQuery();
						while(rs.next()){
							RecordVo rv=new RecordVo();
							rv.setId(rs.getString(1).split("@")[0]);
							rv.setNickname(uv.getNickname());
							rv.setScore(rs.getInt(2));
							list.get(i).get(j).add(rv);
							System.out.println(rv.getId()+" "+rv.getNickname()+" "+rv.getScore());
						}
						while(list.get(i).get(j).size()<5){
							RecordVo rv=new RecordVo();
							rv.setId("NO0");
							rv.setNickname("No User");
							rv.setScore(dftnum[i][j]);
							list.get(i).get(j).add(rv);
							System.out.println(rv.getId()+" "+rv.getNickname()+" "+rv.getScore());
						}
						System.out.println();
				}
				System.out.println();
			}
			return list;
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("개인 랭킹 조회 시 오류가 발생하였습니다.");
		}finally{
			if(pstmt!=null)pstmt.close();
		}
	}
}
